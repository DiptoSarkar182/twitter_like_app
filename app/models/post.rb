class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 500 }
  validates :user, presence: true
  validate :post_media_size_under_limit, :post_media_type_valid

  has_one_attached :post_media

  before_destroy :purge_post_media
  before_update :purge_post_media, if: :post_media_changed?

  private
  def post_media_size_under_limit
    if post_media.attached? && post_media.blob.byte_size > 10.megabytes
      post_media.purge
      errors.add(:post_media, 'is too large (max is 10MB)')
    end
  end

  def post_media_type_valid
    if post_media.attached? && !post_media.content_type.in?(%w(image/jpeg image/png video/mp4))
      post_media.purge
      errors.add(:post_media, 'must be an image or a MP4 video')
    end
  end

  def purge_post_media
    if Rails.env.production?
      public_id = "ruby_on_rails/twitter_like_app/#{post_media.key}"
      Cloudinary::Api.delete_resources([public_id], type: :upload, resource_type: :auto)
    end
  end

  def post_media_changed?
    post_media.attached? && post_media.attachment.blob_id_changed?
  end
end

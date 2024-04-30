class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true, length: { minimum: 2 }

  has_many :posts, dependent: :destroy
  has_many :following_relationships, class_name: 'Follow', foreign_key: 'user_id', dependent: :destroy
  has_many :following, through: :following_relationships, source: :follow

  has_many :follower_relationships, class_name: 'Follow', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :user

  def full_name
    "#{first_name } #{last_name}"
  end
end

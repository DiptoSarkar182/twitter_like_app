class UsersProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc)
    @following_count = @user.following.count
    @followers_count = @user.followers.count
  end
end

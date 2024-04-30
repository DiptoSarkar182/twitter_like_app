class FollowsController < ApplicationController

  def follow_user
    @user = User.find(params[:id])
    @follow_user = Follow.create(follow_id: @user.id, user_id: current_user.id)
    respond_to do |format|
      if @follow_user.save
        format.html {redirect_to users_profile_path, notice: "You are now following #{@user.full_name}" }
      else
        format.html {redirect_to users_profile_path, alert: "Something went wrong... Please try again" }
      end
    end
  end

  def unfollow_user
    @user = User.find(params[:id])
    @follow_user = Follow.find_by(follow_id: @user.id, user_id: current_user.id)
    respond_to do |format|
      if @follow_user.destroy
        format.html {redirect_to users_profile_path, notice: "You are no longer following #{@user.full_name}" }
      else
        format.html {redirect_to users_profile_path, alert: "Something went wrong... Please try again" }
      end
    end
  end

  def show_followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def show_following
    @user = User.find(params[:id])
    @followings = @user.following
  end
end

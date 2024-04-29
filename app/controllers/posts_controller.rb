class PostsController < ApplicationController
  before_action :authorize_user, only: [:edit, :update, :destroy]
  # /
  def index
    @posts = Post.all.order('created_at DESC')
  end

  # /posts/new
  def new
    @post = Post.new
  end

  # /posts/
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html {redirect_to root_path, notice: "Post created successfully"}
      else
        format.html {render 'new', status: :unprocessable_entity}
      end
    end
  end

  # /posts/:id
  def show
    @post = Post.find(params[:id])
  end

  # /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # /posts/:id
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html {redirect_to post_path, notice: "Post updated successfully!"}
      else
        format.html {render 'edit', status: :unprocessable_entity }
      end
    end
  end

  # /posts/:id
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: "Post deleted successfully!"
  end

  private
  def post_params
    params.require(:post).permit(:body, :post_media)
  end


  def authorize_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

end

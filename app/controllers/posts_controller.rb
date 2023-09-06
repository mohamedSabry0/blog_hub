class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @user = User.find(params[:user_id])
    @post.author_id = current_user.id
    @post.save!
    redirect_to user_post_path(@user, @post)
  end
end

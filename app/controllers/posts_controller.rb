class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, comments: :author)
  end

  def show
    @post = Post.includes(:author, :comments, comments: :author).find(params[:id])
    @user = @post.author
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

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = @post.comments.create(params.require(:comment).permit(:text))
    @comment.author_id = current_user.id
    @comment.save!
    redirect_to user_post_path(@user, @post)
  end
end

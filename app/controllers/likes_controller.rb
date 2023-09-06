class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = @post.likes.create!(author_id: current_user.id)
    redirect_to user_post_path(@user, @post)
  end
end

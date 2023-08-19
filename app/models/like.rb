class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_likes_counter_on_create
  after_destroy :update_likes_counter_on_destroy

  def update_likes_counter_on_create
    post.increment!(:likes_counter)
  end

  def update_likes_counter_on_destroy
    post.decrement!(:likes_counter)
  end
end

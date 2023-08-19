class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_comments_counter_on_create
  after_destroy :update_comments_counter_on_destroy

  def update_comments_counter_on_create
    post.increment!(:comments_counter)
  end

  def update_comments_counter_on_destroy
    post.decrement!(:comments_counter)
  end
end

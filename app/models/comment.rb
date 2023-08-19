class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_comments_counter_on_create
  after_destroy :update_comments_counter_on_destroy

  def update_comments_counter_on_create
    update_comments_counter(1)
  end

  def update_comments_counter_on_destroy
    update_comments_counter(-1)
  end

  def update_comments_counter(value)
    post.comments_counter += value
    post.save
  end
end

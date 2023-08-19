class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  after_create :update_likes_counter_on_create
  after_destroy :update_likes_counter_on_destroy

  def update_likes_counter_on_create
    update_likes_counter(1)
  end

  def update_likes_counter_on_destroy
    update_likes_counter(-1)
  end

  def update_likes_counter(value)
    author.likes_counter += value
    author.save
  end

  def five_most_recent_own_comments
    Comment.where(post: self).order(created_at: :desc).limit(5)
  end
end

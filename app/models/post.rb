class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  after_create :update_posts_counter_on_create
  after_destroy :update_posts_counter_on_destroy

  def update_posts_counter_on_create
    update_posts_counter(1)
  end

  def update_posts_counter_on_destroy
    update_posts_counter(-1)
  end

  def update_posts_counter(value)
    author.posts_counter += value
    author.save
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

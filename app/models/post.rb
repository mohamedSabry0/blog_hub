class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  after_create :update_posts_counter_on_create
  after_destroy :update_posts_counter_on_destroy

  def update_posts_counter_on_create
    author.increment!(:posts_counter)
  end

  def update_posts_counter_on_destroy
    author.decrement!(:posts_counter)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_posts_counter_on_create
  after_destroy :update_posts_counter_on_destroy

  def update_posts_counter_on_create
    author.increment!(:posts_counter)
  end

  def update_posts_counter_on_destroy
    author.decrement!(:posts_counter)
  end

  def five_most_recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end
end

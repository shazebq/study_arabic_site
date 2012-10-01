class ForumPost < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids

  belongs_to :user
  has_many :categories_forum_posts
  has_many :categories, through: :categories_forum_posts

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }
end

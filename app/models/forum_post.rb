class ForumPost < ActiveRecord::Base
  attr_accessible :category_id, :content, :title, :user_id, :views_count, :votes_count

  belongs_to :user
  has_many :categories_forum_posts
  has_many :categories, through: :categories_forum_posts

end

class Category < ActiveRecord::Base
  attr_accessible :name, :parent_category_id

  has_many :categories_forum_posts
  has_many :forum_posts, through: :categories_forum_posts
end

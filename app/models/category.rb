class Category < ActiveRecord::Base
  attr_accessible :name, :category_parent_id

  has_many :categories_forum_posts
  has_many :forum_posts, through: :categories_forum_posts
  belongs_to :category_parent

  #scope :arabic_language, where("category_parent_id = ?", Category.find_by_name("Arabic Language").id)
  #scope :study_abroad, where("category_parent_id = ?", Category.find_by_name("Study Abroad").id)
  #scope :countries, where("category_parent_id = ?", Category.find_by_name("Countries").id)

end

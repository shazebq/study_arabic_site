class Category < ActiveRecord::Base
  has_many :forum_posts
  belongs_to :parent_category

  attr_accessible :name, :parent

end

class CategoriesForumPost < ActiveRecord::Base
  attr_accessible :category_id, :forum_post_id

  belongs_to :category
  belongs_to :forum_post
end

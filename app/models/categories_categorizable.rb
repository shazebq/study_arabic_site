class CategoriesCategorizable < ActiveRecord::Base
  attr_accessible :categorizable_id, :categorizable_type, :category_id

  belongs_to :category
  # in a regular join table, you wouldn't have the polymorphic option
  # it would just be belongs_to :forum_post or whatever
  belongs_to :categorizable, polymorphic: :true
end

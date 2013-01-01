class Resource < ActiveRecord::Base
  attr_accessible :description, :difficulty_level, :downloads_count, :title, :user_id, :views_count, :votes_count

  # normally, in a regular (non polymorph join), you wouldn't have the as: option
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  has_many :categories, through: :categories_categorizables  # just like regular join table
end

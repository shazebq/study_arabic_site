class Resource < ActiveRecord::Base
  attr_accessible :description, :difficulty_level, :downloads_count, :title, :user_id, :views_count, :votes_count, :resource_file, :category_ids

  # normally, in a regular (non polymorph join), you wouldn't have the as: option
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  # just like regular join table
  has_many :categories, through: :categories_categorizables
  belongs_to :user
  # need this for paper clip
  has_attached_file :resource_file

  validates :title, :description, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :description, length: {maximum: 5000 }
end

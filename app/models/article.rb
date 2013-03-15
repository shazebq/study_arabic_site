class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids , :images_attributes

  has_many :views, as: :viewable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy 
  has_many :categories, through: :categories_categorizables

  has_many :images, as: :imageable, dependent: :destroy

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 130 }
  validates :content, length: {maximum: 10000 }

  accepts_nested_attributes_for :images
end

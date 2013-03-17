class Article < ActiveRecord::Base
  extend Searching
  include Voting
  include Scoping
  include PgSearch

  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids , :images_attributes
  after_initialize :init

  has_many :views, as: :viewable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy 
  has_many :categories, through: :categories_categorizables

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy

  belongs_to :user

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 130 }
  validates :content, length: {maximum: 10000 }

  accepts_nested_attributes_for :images

  SCOPES = ["most_recent", "most_views", "most_votes"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.comments_count ||= 0
  end
end

class Article < ActiveRecord::Base

  def to_param
    "#{id}-#{title.parameterize}"
  end

  extend Searching
  include Voting
  include Scoping
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {categories: :name, comments: :content} # needed so it searches associated records as well

  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids , :photos_attributes, :images_attributes, :as => [:default, :admin] 
  after_initialize :init

  has_many :views, as: :viewable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy 
  has_many :categories, through: :categories_categorizables

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy

  has_many :photos, as: :photographable, dependent: :destroy

  belongs_to :user

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 100 }
  validates :content, length: {maximum: 20000 }

  accepts_nested_attributes_for :images

  accepts_nested_attributes_for :photos

  SCOPES = ["most_recent", "most_views", "most_votes"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.comments_count ||= 0
  end
end

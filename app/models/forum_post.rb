class ForumPost < ActiveRecord::Base
  extend Searching
  include Voting
  include Scoping
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {categories: :name, answers: :content} # needed so it searches associated records as well
  #multisearchable :against => [:title, :content]

  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :answers_count, :category_ids
  after_initialize :init

  belongs_to :user

  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  has_many :categories, through: :categories_categorizables

  has_many :votes, as: :voteable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }

  SCOPES = ["most_recent", "most_views", "most_votes", "most_answers", "unanswered"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.answers_count ||= 0
  end


end

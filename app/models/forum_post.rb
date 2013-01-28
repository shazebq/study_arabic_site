class ForumPost < ActiveRecord::Base
  include Voting
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :answers_count, :category_ids
  after_initialize :init

  belongs_to :user

  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  has_many :categories, through: :categories_categorizables

  has_many :votes, as: :voteable
  has_many :views, as: :viewable
  has_many :answers

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }

  scope :most_recent, order("created_at DESC")
  scope :most_views, order("views_count DESC, created_at DESC")
  scope :most_votes, order("votes_count DESC, created_at DESC")
  scope :most_answers, order("answers_count DESC, created_at DESC")
  scope :unanswered, where("answers_count = ?", 0).order("created_at DESC")

  SCOPES = ["most_recent", "most_views", "most_votes", "most_answers", "unanswered"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.answers_count ||= 0
  end
end

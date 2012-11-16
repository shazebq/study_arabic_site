class ForumPost < ActiveRecord::Base
  include Voting
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids
  after_initialize :init

  belongs_to :user
  has_many :categories_forum_posts
  has_many :categories, through: :categories_forum_posts
  has_many :votes, as: :voteable
  has_many :views, as: :viewable
  has_many :answers

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
  end

end

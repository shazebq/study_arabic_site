class ForumPost < ActiveRecord::Base
  include Voting
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids
  after_initialize :init

  belongs_to :user
  has_many :categories_forum_posts
  has_many :categories, through: :categories_forum_posts
  has_many :votes, as: :voteable
  has_many :answers

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
  end

  def self.count_vote(voteable_id, user_id, type)
    if type == "up"
      new_vote = Vote.create(voteable_id: voteable_id, voteable_type: "ForumPost", user_id: user_id)
    else
      down_vote = Vote.where("voteable_id = ? AND voteable_type = ? AND user_id = ?", voteable_id, "ForumPost", user_id).first
      down_vote.destroy if down_vote
    end
    return ForumPost.find(voteable_id).votes.count
  end


end

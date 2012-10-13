class ForumPost < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :category_ids
  after_initialize :init

  belongs_to :user
  has_many :categories_forum_posts
  has_many :categories, through: :categories_forum_posts
  has_many :votes

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: {maximum: 5000 }

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
  end

  def self.count_vote(forum_post, type)
    if type == "up"
      new_vote = Vote.create!(user_id: 4, forum_post_id: 3)
    else
      Vote.where("user_id = ? AND forum_post_id = ?", 1, 3).first.destroy
    end
    return Vote.where("forum_post_id = 3").count
  end
end

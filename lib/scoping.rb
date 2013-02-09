module Scoping
  def self.included(c)
    c.scope :most_recent, c.order("created_at DESC")
    c.scope :most_views, c.order("views_count DESC, created_at DESC")
    c.scope :most_votes, c.order("votes_count DESC, created_at DESC")
    c.scope :most_answers, c.order("answers_count DESC, created_at DESC")
    c.scope :unanswered, c.where("answers_count = ?", 0).order("created_at DESC")
    c.scope :most_downloads, c.order("downloads_count DESC, created_at DESC")
  end
end

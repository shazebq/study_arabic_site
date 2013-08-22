module Scoping
  def self.included(c)
    c.scope :most_recent, c.order("id DESC")
    c.scope :most_views, c.order("views_count DESC, id DESC")
    c.scope :most_votes, c.order("votes_count DESC, id DESC")
    c.scope :most_answers, c.order("answers_count DESC, id DESC")
    c.scope :unanswered, c.where("answers_count = ?", 0).order("id DESC")
    c.scope :most_downloads, c.order("downloads_count DESC, id DESC")
  end
end

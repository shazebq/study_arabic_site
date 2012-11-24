class Answer < ActiveRecord::Base
  include Voting
  attr_accessible :content, :forum_post_id, :user_id

  belongs_to :user
  belongs_to :forum_post
  has_many :votes, :as => :voteable

  # orders by number of votes


end

#scope :by_votes, select("answers.*, votes.*, count(answers.id) as vote_count")
#                .joins(:votes)
#                .group("answers.id")

#scope :by_votes, select("answers.*, votes.*, count(answers.id) as vote_count")
#.joins("left outer join votes on votes.voteable_id = answers.id")
#.group("answers.id")


#joins(:votes).
#    select("answers.*, count(votes.id) as vote_count").
#    order("vote_count DESC").group("answers.id")

#scope :by_votes, joins(:votes).
#    select("answers.*, count(answers.id) as votes").
#    group("votes.voteable_id, answers.created_at DESC")






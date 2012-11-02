class Answer < ActiveRecord::Base
  include Voting
  attr_accessible :content, :forum_post_id, :user_id

  belongs_to :user
  belongs_to :forum_post
  has_many :votes, :as => :voteable

end

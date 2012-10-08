class Vote < ActiveRecord::Base
  attr_accessible :forum_post_id, :user_id

  belongs_to :forum_post

  validates_uniqueness_of :user_id, :scope => [:forum_post_id]
end

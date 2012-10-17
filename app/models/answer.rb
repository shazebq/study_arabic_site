class Answer < ActiveRecord::Base
  attr_accessible :content, :forum_post_id, :user_id

  belongs_to(:user)
  belongs_to(:forum_post)
end

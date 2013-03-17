class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :user_id, :content

  belongs_to :commentable, polymorphic: :true 
  belongs_to :user
  
  scope :saved_records, where("ID IS NOT ?", nil)

  validates :user_id, :content, presence: true
end

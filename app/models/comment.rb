class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :user_id, :content, :as => [:default, :admin] 

  belongs_to :commentable, polymorphic: :true, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  has_many :responsible_party_notifications, class_name: "Notification", :as => :responsible_party_object, dependent: :destroy
  has_many :recipient_notifications, class_name: "Notification", :as => :recipient_object, dependent: :destroy

  # to deal with the Comment.new dilemma where the new blank comment record in the controller is counted undesirably
  scope :saved_records, where("ID IS NOT ?", nil)
  scope :most_recent, order("created_at DESC")

  validates :user_id, :content, presence: true

  validates :content, length: { maximum: 1000 }
end

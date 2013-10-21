class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id, :voteable_type, :as => [:default, :admin]

  belongs_to :voteable, polymorphic: true, counter_cache: true
  belongs_to :user

  has_many :responsible_party_notifications, class_name: "Notification", :as => :responsible_party_object, dependent: :destroy

  validates_uniqueness_of :user_id, :scope => [:voteable_id, :voteable_type]
end

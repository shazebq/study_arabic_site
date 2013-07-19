class Notification < ActiveRecord::Base
  attr_accessible :recipient_id, :recipient_object_id, :recipient_object_type, :responsible_party_id, :responsible_party_object_id, :responsible_party_object_type, :verb

  belongs_to :recipient, class_name: "User"
  belongs_to :responsible_party, class_name: "User"

  belongs_to :recipient_object, polymorphic: true
  belongs_to :responsible_party_object, polymorphic: true
end

class Notification < ActiveRecord::Base
  attr_accessible :recipient_id, :recipient_object_id, :recipient_object_type, :responsible_party_id, :responsible_party_object_id, :responsible_party_object_type, :verb
end

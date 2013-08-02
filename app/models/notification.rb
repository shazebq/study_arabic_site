class Notification < ActiveRecord::Base
  attr_accessible :recipient_id, :recipient_object_id, :recipient_object_type, :responsible_party_id, 
                  :responsible_party_object_id, :responsible_party_object_type, :verb, :checked

  belongs_to :recipient, class_name: "User"
  belongs_to :responsible_party, class_name: "User"

  belongs_to :recipient_object, polymorphic: true
  belongs_to :responsible_party_object, polymorphic: true

  scope :only_new, where("checked IS NOT true") 
  scope :by_votes, order("votes_count desc, id desc")

  def self.generate_notification(recipient, responsible_party, recipient_object, responsible_party_object)
    unless recipient == responsible_party
      create(recipient_id: recipient.id, responsible_party_id: responsible_party.id,
            recipient_object_id: recipient_object.id, recipient_object_type: recipient_object.class.name,
            responsible_party_object_id: responsible_party_object.id, responsible_party_object_type: responsible_party_object.class.name)
    end
  end
end

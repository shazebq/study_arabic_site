class Message < ActiveRecord::Base
  attr_accessible :content, :conversation_id, :recipient_id, :sender_id, :subject

  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :conversation, class_name: "Message"
  
  has_many :replies, class_name: "Message", foreign_key: "conversation_id"

  # returns all of the messages that belong to a particular conversation (the first message)
  scope :in_reply_to, lambda { |message| where(conversation_id:  message.id).order('created_at') }
  default_scope order("created_at DESC")
 
  # i.e. messages which have not been marked as "delete"
  scope :active_messages, lambda { |message_type| where("#{message_type}_delete IS NOT true") } 

  validates :subject, :content, :sender_id, :recipient_id, presence: true
  validates :subject, length: { maximum: 130 }
  validates :content, length: { maximum: 5000 }

  def delete_from_sender
    self.sender_delete = true
    self.save
  end

  def delete_from_recipient
    self.recipient_delete = true
    self.save
  end

end

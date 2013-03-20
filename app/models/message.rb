class Message < ActiveRecord::Base
  attr_accessible :content, :conversation_id, :recipient_id, :sender_id, :subject

  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :conversation, class_name: "Message"
  
  has_many :replies, class_name: "Message", foreign_key: "conversation_id"

  # returns all of the messages that belong to a particular conversation (the first message)
  scope :in_reply_to, lambda { |message| where(:conversation_id => message.id).order('created_at') }
end

class Message < ActiveRecord::Base
  attr_accessible :checked, :content, :conversation_id, :recipient_id, :sender_id, :subject, :recipient_delete, :sender_delete, :as => [:default, :admin] 

  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :conversation, class_name: "Message"
  
  has_many :replies, class_name: "Message", foreign_key: "conversation_id"

  # returns all of the messages that belong to a particular conversation (the first message)
  scope :in_reply_to, lambda { |message| where(conversation_id:  message.id).order('created_at') }
  default_scope order("created_at DESC")
 
  # i.e. messages which have not been marked as "delete"
  scope :active_messages, lambda { |message_type| where("#{message_type}_delete IS NOT true") } 

  scope :unread_messages, where("checked IS NOT true") 

  validates :subject, :content, :sender_id, :recipient_id, presence: true
  validates :subject, length: { maximum: 130 }
  validates :content, length: { maximum: 5000 }

  def direct_parent
    if self.conversation
      messages = Message.in_reply_to(self.conversation)
      # grab the message which is next in line from self
      parent = messages.where("created_at < ?", self.created_at).limit(1).first
      if parent.nil?
        self.conversation
      else
        parent
      end
    end
  end

  # built in authorization i.e. if current user is not either the sender
  # or recipient, then nothing happens
  def self.mark_list_as_deleted(message_ids, current_user)
    message_ids.each do |message_id|
      message = Message.find(message_id)
      if current_user == message.recipient
        message.update_attributes(recipient_delete: true)
      elsif current_user == message.sender
        message.update_attributes(sender_delete: true)
      end
    end
  end
end

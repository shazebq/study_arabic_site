class ContactMessage

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :subject, :message

  validates :email, presence: true, email_format: true
  validates :subject, presence: true, length: { maximum: 100 } 
  validates :message, presence: true, length: { maximum: 1000 } 
 
  # this is called when you create the contact message object 
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end

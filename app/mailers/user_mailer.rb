class UserMailer < ActionMailer::Base
  default from: "admin@studyarabic.com"

  def message_alert(recipient, sender, message)
    @recipient = recipient 
    @sender = sender
    @message = message
    mail(:to => recipient.email, :subject => "You have received a message")
  end
end

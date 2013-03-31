class ContactMessageMailer < ActionMailer::Base
  default from: "admin@studyarabic.com"
  default :to => "shazebq@gmail.com" 

  def new_message(message)
    @message = message
    mail(:subject => "StudyArabic.com #{message.subject}")
  end

end

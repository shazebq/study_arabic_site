class UserMailer < ActionMailer::Base
  default from: "admin@studyarabic.com"

  def message_alert(recipient, sender, message)
    @recipient = recipient 
    @sender = sender
    @message = message
    mail(:to => recipient.email, :subject => "You have received a message")
  end

  # send email to the questioner
  def answer_alert(user, forum_post, answer)
    @user = user
    @forum_post = forum_post
    @answer = answer
    mail(:to => user.email, :subject => "Your question has been answered")
  end

  # send email to other answerers
  def alert_other_answerers(users, forum_post, answer)
    @users = users
    @forum_post = forum_post
    @answer = answer
    mail(:to => users.map { |u| u.email }, :subject => "Another answer has been added to a question you answered")
  end
end

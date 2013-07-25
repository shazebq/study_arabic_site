module NotificationsHelper
  VERBS = {:answer => "answered", :vote  => "up voted", :comment => "commented on", :review => "reviewed"}
  #STANDARD_ITEMS = ["Answer", "Review", "Vote"]

  def notification_link(notification)
    notification_sentence(notification)         
  end

  def notification_sentence(notification)
    # e.g. jsmith answered your question 
    responsible_party = notification.responsible_party.username
    verb = VERBS[notification.responsible_party_object_type.underscore.to_sym]
    if notification.recipient_object_type == "ForumPost" || notification.recipient_object_type == "TeacherProfile"
      sentence_object = "your question" if notification.recipient_object_type == "ForumPost"
      sentence_object = "you" if notification.recipient_object_type == "TeacherProfile"
    else
      sentence_object = "your #{notification.recipient_object_type.underscore}"
    end
    sentence = "#{responsible_party} #{verb} #{sentence_object}"
  end

  def link(notification)
    # for review and answer first
    # then edge cases like comment and vote
    
  end

end

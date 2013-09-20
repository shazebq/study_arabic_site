module NotificationsHelper
  VERBS = {:answer => "answered", :vote  => "up voted", :comment => "commented on", :review => "reviewed"}

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

  def public_activity_setence

  end

  
end

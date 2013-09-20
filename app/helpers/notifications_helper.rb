module NotificationsHelper
  VERBS = {:answer => "answered", :vote  => "up voted", :comment => "commented on", :review => "reviewed"}

  def notification_sentence(notification)
    # e.g. jsmith answered your question 
    responsible_party = get_responsible_party(notification)
    verb = get_verb(notification)
    sentence_object = get_sentence_object(notification) 
    sentence = "#{responsible_party} #{verb} #{sentence_object}"
  end

  def public_activity_sentence(notification)
    responsible_party = get_responsible_party(notification)
    verb = get_verb(notification) 
    sentence_object = get_pa_sentence_object(notification)
    sentence = "#{responsible_party} #{verb} #{sentence_object}"
  end

  def get_verb(notification)
    verb = VERBS[notification.responsible_party_object_type.underscore.to_sym]
  end

  def get_responsible_party(notification)
    notification.responsible_party.username
  end

  def get_sentence_object(notification)
    if notification.recipient_object_type == "ForumPost" || notification.recipient_object_type == "TeacherProfile"
      sentence_object = "your question" if notification.recipient_object_type == "ForumPost"
      sentence_object = "you" if notification.recipient_object_type == "TeacherProfile"
    else
      sentence_object = "your #{notification.recipient_object_type.underscore}"
    end
    sentence_object
  end

  # pa = public activity
  def get_pa_sentence_object(notification)
    item_owner = "#{notification.recipient.username}'s"
    if notification.recipient_object_type == "ForumPost"
      item = "question"
    else
      item = notification.recipient_object_type.underscore.gsub("_", " ") 
    end
    "#{item_owner} #{item}" 
  end
  
end

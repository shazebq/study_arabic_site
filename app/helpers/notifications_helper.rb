module NotificationsHelper
  VERBS = {:answer => "answered", :vote  => "up voted", :comment => "commented on", :review => "reviewed"}
  STANDARD_ITEMS = ["Answer", "Review", "Vote"]

  def notification_link(notification)
            
  end

  def notification_sentence(notification)
    # jsmith answered your question 

    verb = VERBS[notification.responsible_party_object_type.underscore.to_sym]
    sentence = "#{notification.responsible_party.username} #{verb}"
  end

  def link(notification)

  end

end

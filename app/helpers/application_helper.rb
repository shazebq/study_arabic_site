module ApplicationHelper
  def get_categories(category_name)
    CategoryParent.find_by_name(category_name).categories
  end

  def scope_name_to_link_text(original)
    if original.include?("_")
      list = original.split("_")
      "#{list[0].capitalize} #{list[1].capitalize}"
    else
      original.capitalize
    end
  end

  def full_name(user)
    "#{user.first_name} #{user.last_name}" 
  end

  def user_type(user)
    if user.profile_type == "TeacherProfile"
      "Teacher"
    else
      "Student"
    end
  end
  
  def user_type_controller(user)
    "#{user_type(@user).downcase}_profiles"
  end

  def authorized?(user)
    if user_signed_in? && (@user == current_user)
      true
    else
      false
    end
  end
end

class BigDecimal
  # rounds to the nearing half
  def round_point5
    (self*2).round / 2.0
  end
end

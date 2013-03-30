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

  def gender_word(gender)
    return "Male" if gender == "m"
    return "Female" if gender == "f"
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

  def truncate_text(text, length, item)
    raw(truncate(text, length: length, omission: (link_to "<span style='font-style: italic'> ...continue reading</span>".html_safe, item), separator: " ")) 
  end

  # this should be used in any case where the image
  # is from the images table (nested polymorphic)
  def handle_image(image)
    if image
      image_tag(image, class: "floatLeft").html_safe
    else
      image_tag("/images/thumb_sub.png", class: "floatLeft").html_safe
    end
  end

  
  # for pluralizing without the number, just the object
  def simple_pluralize count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

  # for marking offending labels in forms 
  def label_class(resource, field_name)
    if resource.errors[field_name].any?
      "error_label".html_safe
    else
      "".html_safe
    end
  end

  # for alternative background colors in indexes
  def get_alternating_class(i)
    if (i+1).odd?
      "index_well"
    else
      "index_well_white"
    end
  end

  # simple_format without the p tags wrapping the content
  def modified_sf(text, html_options={}, options={})
    text = '' if text.nil?
    text = text.dup
    start_tag = tag('span', html_options, true)
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.insert 0, start_tag
    text.html_safe.safe_concat("</span>")
  end
  
end

class BigDecimal
  # rounds to the nearing half
  def round_point5
    (self*2).round / 2.0
  end
end

module UserPagesHelper
  def bool_display(value)
    if value == true
      "<i class='icon-check icon-large'></i>".html_safe
    elsif value == false
      "<i class='icon-check-empty icon-large'></i>".html_safe
    else
      "<i class='icon-question-sign icon-large'></i>".html_safe
    end
  end

  def provider_name(given_name)
    if given_name == :google_oauth2
      "Google"
    else
      given_name.to_s.titleize
    end
  end
end

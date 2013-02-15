module UserPagesHelper
  def bool_display(value)
    if value == true
      "<i class='icon-check icon-large'></i>".html_safe
    else
      "<i class='icon-check-empty icon-large'></i>".html_safe
    end
  end
end

module ApplicationHelper
  def get_categories(category_name)
    CategoryParent.find_by_name(category_name).categories
  end

end

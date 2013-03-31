class CategoryParent < Category
  has_many :categories

  # get posts of all children categories
  def collect_all_posts(item)
    category_ids = self.categories.map { |c| c.id }
    # in order to get the parent categories general items as well
    category_ids << self.id
    #need a way to get distinct posts or resources
    item.classify.constantize.joins(:categories).where("category_id IN (?)", category_ids).uniq
  end
end

#comments

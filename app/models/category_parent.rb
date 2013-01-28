class CategoryParent < Category
  has_many :categories

  # get posts of all children categories
  def collect_all_posts
    category_ids = self.categories.map { |c| c.id }
    #need a way to get distinct posts
    ForumPost.joins(:categories).where("category_id IN (?)", category_ids).uniq.most_recent
  end
end

#comments
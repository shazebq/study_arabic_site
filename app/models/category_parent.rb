class CategoryParent < Category
  has_many :categories

  def collect_all_posts
    category_ids = self.categories.map { |c| c.id }
    ForumPost.joins(:categories).where("category_id IN (?)", category_ids).distinct_posts
  end
end
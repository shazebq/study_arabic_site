class CategoryParent < Category
  has_many :categories

  def collect_all_posts
    all_posts = []
    self.categories.each do |category|
      all_posts += category.forum_posts
    end
    all_posts.uniq!
  end




end
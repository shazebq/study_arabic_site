class HomePagePresenter
  def feature_article
    # user equal or syntax to memoize
    @feature_article ||= Article.most_recent.first
  end

  def articles
    @articles ||= Article.most_recent.limit(2).offset(1)
  end

  def questions
    @questions ||= ForumPost.most_views.limit(5)
  end
   
  def forums
    @forums ||= Category.popular_forums.limit(5)
  end

  def centers
    @centers ||= Center.order_by_average_rating.limit(5)
  end
end

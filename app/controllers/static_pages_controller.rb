class StaticPagesController < ApplicationController
  SEARCH_OPTIONS = { "Forums" => "forum_posts", "Teachers" => "teacher_profiles", "Centers/Programs" => "centers",
                      "Resources" => "resources", "Articles" => "articles" }

  def home
    @feature_article = Article.most_recent.first
    @articles = Article.most_recent.limit(2).offset(1)
    @questions = ForumPost.most_views.limit(5)
    @forums = Category.popular_forums.limit(5)
  end

  def about_us
  end

  # just redirects to the appropriate controller, passing the query along
  def site_search
    redirect_to controller: params[:item_type], action: "search", query: params[:query] 
  end
end

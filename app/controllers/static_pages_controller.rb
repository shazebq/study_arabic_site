class StaticPagesController < ApplicationController
  SEARCH_OPTIONS = { "Forums" => "forum_posts", "Teachers" => "teacher_profiles", "Centers/Programs" => "centers",
                      "Resources" => "resources", "Articles" => "articles" }

  def home
  end

  def about_us
  end

  def site_search
    searcher = Searcher.new
    @results = searcher.search(params[:query])
  end
end

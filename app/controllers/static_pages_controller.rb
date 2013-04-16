class StaticPagesController < ApplicationController
  SEARCH_OPTIONS = { "Teachers" => "teacher_profiles", "Centers/Programs" => "centers",
                      "Resources" => "resources", "Articles" => "articles" }

  def home
    @presenter = HomePagePresenter.new
  end

  def about
  end

  def register
  end

  def contact
    return render text: "contact"
  end

  # just redirects to the appropriate controller, passing the query along
  def site_search
    redirect_to controller: params[:item_type], action: "search", query: params[:query] 
  end
end

class CategorizableItemsController < ApplicationController
  def index
    @scopes = params[:controller].classify.constantize::SCOPES
    @current_scope = params[:order_by] || "most_recent"  # default the scope to most_recent
    if params[:category_id]
      @category = CategoryParent.find(params[:category_id])
        if @category.categories.any?  # if it's a parent category
          @items = @category.collect_all_posts(params[:controller]).send(@current_scope) 
        else # if it's not a parent category
          @items = @category.send(params[:controller]).send(@current_scope)
        end
    else
      # call appropriate scope here
      @items = params[:controller].classify.constantize.send(@current_scope)
    end
  end 

  def search
    @scopes = params[:controller].classify.constantize::SCOPES
    @items = params[:controller].classify.constantize.text_search(params[:query]) 
    render "index"
  end
end

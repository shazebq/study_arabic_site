class CategorizableItemsController < ApplicationController
  def index
    @scopes = params[:controller].classify.constantize::SCOPES
    @current_scope = params[:order_by] || "most_recent"  # default the scope to most_recent
    if params[:category_id]
      @category = CategoryParent.find(params[:category_id])
        if @category.categories.any?
          @items = @category.collect_all_posts(params[:controller]).send(@current_scope) 
        else
          @items = @category.forum_posts.send(@current_scope)
        end
    else
      # call appropriate scope here
      @items = ForumPost.send(@current_scope)
    end
  end 
end

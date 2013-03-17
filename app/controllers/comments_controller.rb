class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    params[:comment][:user_id] = current_user.id
    @commentable = get_somethingable(params) 
    # for the view, so that that @article, for example, is defined in addition to @commentable
    instance_variable_set("@#{@commentable.class.name.underscore}", @commentable)
    # for the possibility that the comment was submitted with an error
    @comment_new = @commentable.comments.create(params[:comment]) 
    flash[:notice] = "Your comment has been successfully added" if @comment_new.valid?
    render template: "articles/show" 
    #redirect_to article_path(Article.find(2))
  end
end



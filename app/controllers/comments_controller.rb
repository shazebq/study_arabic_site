class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    params[:comment][:user_id] = current_user.id
    @commentable = get_somethingable(params) 
    ## for the view, so that that @article, for example, is defined in addition to @commentable
    instance_variable_set("@#{@commentable.class.name.underscore}", @commentable)
    ## for the possibility that the comment was submitted with an error
    @comment_new = @article.comments.create(params[:comment]) 
    flash[:notice] = "Your comment has been successfully added" if @comment_new.valid?
    render "articles/show"
  end

  def edit
    @commentable = get_somethingable(params) 
    instance_variable_set("@#{@commentable.class.name.underscore}", @commentable)
    @comment = Comment.find(params[:id])
  end

  def update
    @commentable = get_somethingable(params)
    instance_variable_set("@#{@commentable.class.name.underscore}", @commentable)
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    if @comment.valid?
      flash[:notice] = "Your comment has been updated"
      redirect_to @commentable 
    else
      render "edit" 
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    Comment.find(params[:id]).destroy
    flash[:notice] = "Your comment has been successfully deleted"
    redirect_to article_path(@article)
  end
end


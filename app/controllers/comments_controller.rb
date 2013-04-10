class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :limit_user_content, only: [:new, :create]
  before_filter :set_commentable, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    params[:comment][:user_id] = current_user.id
    # for the possibility that the comment was submitted with an error
    @comment_new = @commentable.comments.create(params[:comment]) 
    if @comment_new.valid?
      flash[:notice] = "Your comment has been successfully added." 
      redirect_to :back || root_path 
    else
      render "#{@commentable.class.to_s.tableize}/show"
    end
  end

  def edit
    # save the original page on which the comment is actually located
    session[:original_page] = request.referrer
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    if @comment.valid?
      flash[:notice] = "Your comment has been updated."
      redirect_to session[:original_page] || root_path
    else
      render "edit" 
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "Your comment has been successfully deleted."
    redirect_to :back || root_path
  end

  private 

  def set_commentable
    @commentable = get_somethingable(params)
    # for the view, so that that @article, for example, is defined in addition to @commentable
    instance_variable_set("@#{@commentable.class.name.underscore}", @commentable)
  end
end



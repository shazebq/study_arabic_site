class ForumPostsController < ApplicationController
  #after_filter :add_views, only: :show
  before_filter :require_sign_in, only: :new

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = ForumPost.new(params[:forum_post])
    if @forum_post.save
      flash[:success] = "Your post has been added"
      redirect_to forum_post_path(@forum_post)
    else
      # note here, you're simply rendering the template with the variables from here
      render action: "new"
    end
  end

  def show
    @forum_post = ForumPost.find(params[:id])
  end

  def vote
    @forum_post = ForumPost.find(params[:id])
    vote_count = @forum_post.count_vote(params[:id], params[:voteable_type], current_user.id, params[:type])
    respond_to do |format|
      format.json { render :json => vote_count }
    end
  end

  def require_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
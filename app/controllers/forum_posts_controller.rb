class ForumPostsController < ApplicationController
  #after_filter :add_views, only: :show

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
    vote_count = ForumPost.count_vote(params[:id], params[:type])
    respond_to do |format|
      format.json
    end
  end
end
class ForumPostsController < ApplicationController

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = ForumPost.new(params[:forum_post])
    if @forum_post.save
      flash[:success] = "Your post has been added"
    else
      redirect_to :back
    end
  end

end
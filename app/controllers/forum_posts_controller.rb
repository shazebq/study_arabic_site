class ForumPostsController < ApplicationController

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = ForumPost.new(params[:forum_post])
    if @forum_post.save
      flash[:success] = "Your post has been added"
      redirect_to forum_post_path(@forum_post)
    else
      redirect_to :back
    end
  end

  def show
    @forum_post = ForumPost.find(params[:id])
  end

end
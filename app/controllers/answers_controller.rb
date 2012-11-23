class AnswersController < ApplicationController


  def index

  end

  def create
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = @forum_post.answers.create(params[:answer])
    redirect_to forum_post_path(@forum_post)
  end

end
class AnswersController < ApplicationController
  before_filter :require_sign_in, only: :destroy
  before_filter(:only => [:destroy]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }

  def index

  end

  def create
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = @forum_post.answers.create(params[:answer])
    redirect_to forum_post_path(@forum_post)
  end

  def edit
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = @forum_post.answers.find(params[:id])
  end

  def update
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = Answer.find(params[:id])
    @answer.update_attributes(params[:answer])
    redirect_to @forum_post
  end

  def destroy
    @forum_post = ForumPost.find(params[:forum_post_id])
    @forum_post.answers.find(params[:id]).destroy
    redirect_to forum_post_path(@forum_post)
  end

end
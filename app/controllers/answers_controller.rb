class AnswersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :create]
  before_filter :one_answer_per_user, only: [:create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :limit_user_content, only: [:create]

  def index

  end

  def create
    params[:answer][:user_id] = current_user.id
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = @forum_post.answers.new
    @answer_new = @forum_post.answers.create(params[:answer])
    if @answer_new.valid?
      UserMailer.delay.answer_alert(@forum_post.user, @forum_post, @answer_new)  # send email to user who asked question
      UserMailer.delay.alert_other_answerers(@forum_post.answerers_list(current_answerer: @answer_new.user), @forum_post, @answer_new) if @forum_post.answers.count > 1
      Notification.generate_notification(@forum_post.user, current_user, @forum_post, @answer_new)
      flash[:notice] = "Your answer was successfully submitted."
        
    end
    render 'forum_posts/show'
  end

  def edit
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = @forum_post.answers.find(params[:id])
  end

  def update
    @forum_post = ForumPost.find(params[:forum_post_id])
    @answer = Answer.find(params[:id])
    @answer.update_attributes(params[:answer])
    if @answer.valid?
      flash[:notice] = "Your answer was successfully updated."
      redirect_to @forum_post
    else
      render "edit"
    end
  end

  def destroy
    @forum_post = ForumPost.find(params[:forum_post_id])
    @forum_post.answers.find(params[:id]).destroy
    flash[:notice] = "Your answer was successfully deleted."
    redirect_to forum_post_path(@forum_post)
  end

  def one_answer_per_user
    @forum_post = ForumPost.find(params[:forum_post_id]) 
    if @forum_post.users.include?(current_user)
      flash[:notice] = "Sorry, you already answered this question."
      redirect_to @forum_post 
    end
  end

  
end

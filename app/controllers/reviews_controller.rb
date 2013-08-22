class ReviewsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter :teacher_cannot_review_himself, only: [:new, :create]
  before_filter :limit_user_reviews, only: [:new, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }

  def new
    @reviewable = get_somethingable(params)
    @review = @reviewable.reviews.new
  end

  def create
    @reviewable = get_somethingable(params)
    @review = @reviewable.reviews.new(params[:review])
    @review.user_id = current_user.id
    if @review.save
      Notification.generate_notification(@reviewable.user, current_user, @reviewable, @review) if @reviewable.is_a?(TeacherProfile)
      flash[:notice] = "Your review has been successfully submitted."
      redirect_to_reviewable(@reviewable) 
    else
      render "new"
    end
  end

  def show

  end

  def edit
    @reviewable = get_somethingable(params)
    @review = Review.find(params[:id])
  end

  def update
    @reviewable = get_somethingable(params)
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = "Your review has been successfully updated."
      redirect_to_reviewable(@reviewable)
    else
      render "edit"
    end
  end

  def destroy
    @reviewable = get_somethingable(params)
    Review.find(params[:id]).destroy
    flash[:notice] = "Your review has been successfully deleted."
    redirect_to_reviewable(@reviewable)
  end

  # authorization related
  def teacher_cannot_review_himself
    @reviewable = get_somethingable(params)
    if @reviewable.kind_of?(TeacherProfile)
      if @reviewable.user == current_user
        flash[:notice] = "Sorry, you cannot review yourself."
        redirect_to user_path(@reviewable.user.id)
      end
    end
  end

  def limit_user_reviews
    @reviewable = get_somethingable(params)
    if @reviewable.users.include?(current_user)
      flash[:notice] = "Sorry, you cannot write more than one review."
      redirect_to :back 
    end
  end
end

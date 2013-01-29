class ReviewsController < ApplicationController

  def new
    @reviewable = get_reviewable(params)
    @review = @reviewable.reviews.new
  end

  def create
    @reviewable = get_reviewable(params)
    @review = @reviewable.reviews.new(params[:review])
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Your review has been added"
      redirect_to resource_review_path(@reviewable, @review)
    else
      render "new"
    end
  end

  def show

  end



end
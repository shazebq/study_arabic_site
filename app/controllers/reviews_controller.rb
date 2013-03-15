class ReviewsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }

  def new
    @reviewable = get_reviewable(params)
    @review = @reviewable.reviews.new
  end

  def create
    return render text: params
    @reviewable = get_reviewable(params)
    @review = @reviewable.reviews.new(params[:review])
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Your review has been added"
      if @reviewable.is_a?(TeacherProfile) # have to add this condition because redirection should be to show user page, not show teacher profile page
        redirect_to user_path(@reviewable.user)
      else
        redirect_to controller: @reviewable.class.name.underscore.pluralize, action: "show", id: @reviewable.id 
      end
    else
      render "new"
    end
  end

  def show

  end

  def edit
    @review = Review.find(params[:id])
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to(Resource.find(params[:resource_id]))
  end
end

#comments

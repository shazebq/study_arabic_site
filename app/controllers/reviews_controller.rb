class ReviewsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
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
    @reviewable = get_somethingable(params)
    @review = Review.find(params[:id])
  end

  def update
    @reviewable = get_somethingable(params)
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = "Your review has been successfully updated"
    else
      render "edit"
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to(Resource.find(params[:resource_id]))
  end
end

#comments
#def update
#    @resource = Resource.find(params[:id])
#    if @resource.update_attributes(params[:resource])
#      flash[:notice] = "Your question has been updated"
#      redirect_to @resource
#    else
#      render "edit"
#    end
#  end

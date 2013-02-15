class ProfilesController < ApplicationController
  def new
    @profile = params[:controller].classify.constantize.new
    user = @profile.build_user
    image = user.build_image
  end
  
  def create
    # note here, using the controller name to generalize the solution
    @profile = params[:controller].classify.constantize.new(params[params[:controller].singularize])
    if @profile.save
      return render text: "woohoo, teacher profile AND user created!"
    else
      return render text: "boohoo, error!"
    end
  end

  def edit
    @profile = params[:controller].classify.constantize.find(params[:id])
  end

  def update
    @profile = params[:controller].classify.constantize.find(params[:id])
    @profile.update_attributes(params[params[:controller].singularize])
    #return render text: @profile.errors.messages.inspect
    redirect_to user_path(@profile.user)
  end
end

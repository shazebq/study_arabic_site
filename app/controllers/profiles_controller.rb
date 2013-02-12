class ProfilesController < ApplicationController
  def new
    @profile = params[:controller].classify.constantize.new
    @profile.build_user
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
end


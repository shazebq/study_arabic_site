class ImagesController < ApplicationController

  def new
    @imageable = get_somethingable(params)
    @image = @imageable.images.build
  end

  def create
    @imageable = get_somethingable(params) 
    @image = @imageable.images.new(params[:image])
    @image.user_id = current_user.id
    if @image.save
      flash[:notice] = "You image has been successfully added."
      redirect_to @imageable 
    else
      redirect_to "new"
    end
  end

end

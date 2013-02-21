class CentersController < ApplicationController
  include MiscTasks

  def index
    @centers = Center.all
  end

  def new
    @center = Center.new
    @center.build_address
    3.times { @center.images.build }
  end

  def create
    revised_params = handle_city_creation(params[:center])
    @center = Center.new(revised_params)
    if @center.save 
      redirect_to @center
    else
      render action: "new"
    end
  end

  def show 
    @center = Center.find(params[:id]) 
  end

end

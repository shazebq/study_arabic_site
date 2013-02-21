class CentersController < ApplicationController
  def new
    @center = Center.new
    @center.build_address
    5.times { @center.images.build }
  end

  def create
    @center = Center.new(params[:center])
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

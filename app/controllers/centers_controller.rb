class CentersController < ApplicationController
  def new
    @center = Center.new
    @address = @center.build_address
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

  end
end

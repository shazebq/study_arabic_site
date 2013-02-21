class CentersController < ApplicationController
  def new
    @center = Center.new
    @address = @center.build_address
  end

  def create
    @center = Center.create(params[:center])
    return render text: "good job"
  end
end

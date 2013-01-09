class ResourcesController < ApplicationController
  before_filter :require_sign_in, only: [:new, :update, :destroy]
  #before_filter :check_file_type, only: [:new, :update]

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    #return render text: params
    @resource = Resource.new(params[:resource])
    @resource.user_id = current_user.id
    if @resource.save
      flash[:success] = "Your resource has been added"
      redirect_to resource_path(@resource)
    else
      render action: "new"
    end
  end

  def update


  end

  def destroy

  end

  def show
    @resource = Resource.find(params[:id])
  end

  #def check_file_type
  #  return render text: params
  #
  #end


end
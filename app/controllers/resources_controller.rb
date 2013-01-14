class ResourcesController < ApplicationController
  before_filter :require_sign_in, only: [:new, :update, :destroy]
  before_filter :count_view, only: :show

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
    Resource.find(params[:id]).destroy
    redirect_to resources_path
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def download
    @resource = Resource.find(params[:id])
    @resource.downloads_count += 1
    @resource.save
    # serve the paperclip file through the controller rather than the default way
    send_file @resource.resource_file.path, :type => @resource.resource_file.content_type
  end

end
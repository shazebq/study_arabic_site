class ResourcesController < CategorizableItemsController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show

  def new
    @resource = Resource.new
  end

  def create
    #return render text: params testing
    @resource = current_user.resources.new(params[:resource])
    if @resource.save
      flash[:notice] = "Your resource was successfully submitted. We will review it within 24 hours after which it will be added to the site."
      redirect_to resource_path(@resource)
    else
      render action: "new"
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:notice] = "Your question has been updated"
      redirect_to @resource
    else
      render "edit"
    end
  end

  def destroy
    Resource.find(params[:id]).destroy
    flash[:notice] = "Your resource has been successfully deleted"
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

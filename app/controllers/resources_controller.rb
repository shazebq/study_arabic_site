class ResourcesController < CategorizableItemsController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show
  before_filter :limit_user_content, only: [:new, :create]

  def new
    @resource = Resource.new
  end

  def create
    #return render text: params testing
    @resource = current_user.resources.new(params[:resource])
    if @resource.save
      flash[:notice] = "Your resource was successfully submitted."
      #redirect_to resource_path(@resource)
      redirect_to file_upload_resource_path(@resource) 
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
      flash[:notice] = "Your question has been updated."
      redirect_to @resource
    else
      render "edit"
    end
  end

  def destroy
    Resource.find(params[:id]).destroy
    flash[:notice] = "Your resource has been successfully deleted."
    redirect_to resources_path
  end

  def show
    @resource = Resource.find(params[:id])
    @resource.resource_file.key = params[:key]
    @resource.save
  end

  def file_upload
    @resource = Resource.find(params[:id])
    @uploader = @resource.resource_file
    @uploader.success_action_redirect = resource_url(@resource)
  end

  def download
    @resource = Resource.find(params[:id])
    @resource.downloads_count += 1
    @resource.save
    redirect_to @resource.resource_file_url
  end

end

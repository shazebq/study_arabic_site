class ArticlesController < CategorizableItemsController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter :check_staff_or_admin, only: [:new, :create, :edit, :update, :update]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show
  before_filter :limit_user_content, only: [:new, :create]
  before_filter :check_if_notification_destination, only: :show

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new()
    # no longer need this as I'm using inline images in the content field
    #3.times { @article.photos.build }
  end

  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      @article.add_thumbnail_url
      flash[:notice] = "Your article has been successfully created."
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      @article.add_thumbnail_url
      flash[:notice] = "Your article has been successfully updated"
      redirect_to root_path 
    else
      render "edit"
    end
  end

  def destroy

  end

  def check_staff_or_admin
    unless current_user.admin? || current_user.staff_writer?
      redirect_to root_path
    end
  end


end

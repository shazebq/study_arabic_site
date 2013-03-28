class ArticlesController < CategorizableItemsController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter :check_staff_or_admin, only: [:new, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show
  before_filter :limit_user_content, only: [:new, :create]

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new()
    3.times { @article.images.build }  # default of 3 images for the article
  end

  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      flash[:notice] = "Your article has been successfully created"
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

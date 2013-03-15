class ArticlesController < ApplicationController

  def show

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

  end

  def destroy

  end


end

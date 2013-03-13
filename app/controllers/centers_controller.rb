class CentersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  include MiscTasks

  def index
    @countries = Country.joins(:addresses => :center).uniq  # all the countries that centers are located in (unique)
    if params[:ratings_option] == "order_by_reviews"
      @centers = Center.order_by_reviews.country_option(params[:country_option]).paginate(page: params[:page], per_page: 2)
    elsif params[:ratings_option] == "order_by_average_rating"
      @centers = (Center.order_by_average_rating.country_option(params[:country_option]) + 
                  Center.zero_review_records.country_option(params[:country_option])).paginate(page: params[:page], per_page: 2)
    else
      @centers = (Center.order_by_average_rating + Center.zero_review_records).paginate(page: params[:page], per_page: 2)
    end
  end

  def search
    @countries = Country.joins(:addresses => :center).uniq  # all the countries that centers are located in (unique)
    @centers = Center.text_search(params[:query]) 
    render "index"
  end

  def new
    @center = Center.new
    @center.build_address
    3.times { @center.images.build }
  end

  def create
    revised_params = handle_city_creation(params[:center])
    @center = Center.new(revised_params)
    if @center.save 
      redirect_to @center
    else
      3.times { @center.images.build }
      render action: "new"
    end
  end

  def show 
    @center = Center.find(params[:id]) 
  end

  def edit
    @center = Center.find(params[:id])
  end

  def update
    @center = Center.find(params[:id])
    revised_params = handle_city_creation(params[:center])
    @center.update_attributes(revised_params)
    redirect_to @center
  end
end

# comment

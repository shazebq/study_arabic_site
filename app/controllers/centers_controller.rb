class CentersController < ApplicationController
  include MiscTasks

  def index
    @countries = Country.joins(:addresses => :center).uniq  # all the countries that centers are located in (unique)
    if params[:ratings_option] == "order_by_reviews"
      @centers = Center.order_by_reviews.country_option(params[:country_option])
    elsif params[:ratings_option] == "order_by_average_rating"
      @centers = Center.order_by_average_rating.country_option(params[:country_option]) + Center.zero_review_records.country_option(params[:country_option])
    else
      @centers = Center.order_by_average_rating + Center.zero_review_records
    end
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

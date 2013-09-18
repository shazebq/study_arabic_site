class CentersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter(:only => [:update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :limit_user_content, only: [:new, :create]
  include MiscTasks

  def index  
    @countries = Country.joins(:addresses => :center).uniq  # all the countries that centers are located in (unique)
    if params[:ratings_option] == "order_by_reviews"
      @centers = Center.includes(:images).only_approved.order_by_reviews.country_option(params[:country_option]).paginate(page: params[:page], per_page: PER_PAGE)
    elsif params[:ratings_option] == "order_by_average_rating"
      @centers = (Center.includes(:images).only_approved.order_by_average_rating.country_option(params[:country_option]) + 
                  Center.includes(:images).only_approved.zero_review_records.country_option(params[:country_option])).paginate(page: params[:page], per_page: PER_PAGE)
    else
      @centers = (Center.includes(:images).only_approved.order_by_average_rating + Center.includes(:images).only_approved.zero_review_records).paginate(page: params[:page], per_page: PER_PAGE)
    end
    @centers_for_map = Center.get_mappable_attributes(@centers)  
    @map_center = params[:country_option] == "all" || params[:country_option].blank? ? Country::DEFAULT_LAT_LONG : Country.find(params[:country_option]).get_lat_long
  end

  def search
    @countries = Country.joins(:addresses => :center).uniq  # all the countries that centers are located in (unique)
    @centers = Center.only_approved.text_search(params[:query]).paginate(page: params[:page], per_page: PER_PAGE) 
    render "index"
  end

  def new
    @center = Center.new
    @center.build_address
    5.times { @center.images.build }
  end

  def create
    revised_params = handle_city_creation(params[:center], :address)
    @center = current_user.centers.new(revised_params)
    if @center.save 
      flash[:notice] = "Your entry was successfully submitted. We will review it within 24 hours after which it will be added to the site."
      redirect_to @center
    else
      5.times { @center.images.build }
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
    revised_params = handle_city_creation(params[:center], :address)
    if @center.update_attributes(revised_params)
      flash[:notice] = "The entry has been successfully updated."
      redirect_to @center
    else
      render "new"
    end
  end

end

# comment

class CentersController < ApplicationController
  def new
    @center = Center.new
    @center.build_address
    3.times { @center.images.build }
  end

  def create
    city_name = params[:center][:address_attributes][:city_name]
    country_id = params[:center][:address_attributes][:country_id]
    city = City.where(name: city_name, country_id: country_id, country_iso: (Country.find(country_id).iso)).first_or_create
    params[:center][:address_attributes][:city_id] = city.id if city

    @center = Center.new(params[:center])
    if @center.save 
      redirect_to @center
    else
      render action: "new"
    end
  end

  def show 
    @center = Center.find(params[:id]) 
  end
end

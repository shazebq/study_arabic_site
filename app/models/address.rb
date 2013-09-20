class Address < ActiveRecord::Base
  include Mapping
  attr_accessible :address_line, :city_name, :country_id, :city_id, :latitude, :longitude, :as => [:default, :admin]
  attr_accessor :city_name
  belongs_to :country
  belongs_to :city
  has_one :center

  # validations

  validates :country_id, :city_name, presence: true 
  validates :address_line, length: { maximum: 65 }, reduce: true

  unless Rails.env == "test"
    geocoded_by :full_address
    # set this up as delayed job
    after_validation :geocode
  end
  
  def full_address
    if address_line?
      "#{address_line}, #{city.name}, #{country.name}"
    else
      city_and_country
    end
  end

  def city_and_country
    "#{city.name}, #{country.name}"
  end

  # note: this method will popuate all existing addresses with lat, long 
  # run the method on next deployment
  # for anything outside of U.S. which is basically just
  # Egypt right now, geocode only the city and country
  def populate_lat_long
    geo_data = Geocoder.search(full_address)
    unless geo_data.blank?
      self.update_attribute :latitude, geo_data[0].latitude
      self.update_attribute :longitude, geo_data[0].longitude
    end
  end

end


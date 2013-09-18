class Country < ActiveRecord::Base
  include PgSearch
  #multisearchable :against => :name
  attr_accessible :iso, :name, :as => [:default, :admin] 
  has_many :users
  has_many :addresses
  has_many :cities

  DEFAULT_LAT_LONG = { latitude: 35.0, longitude: -9.0 }  

  def teacher_profiles_in_country
    User.teachers.where(country_id: id).size
  end

  def centers_in_country
    Center.joins(:address).where("addresses.country_id" => id).size
  end

  def get_lat_long
    if self.latitude? && self.longitude?
      { latitude: self.latitude, longitude: self.longitude }
    else
      DEFAULT_LAT_LONG
    end
  end
end

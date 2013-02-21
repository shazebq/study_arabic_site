class Address < ActiveRecord::Base
  attr_accessible :address_line, :city_name, :country_id, :city_id
  attr_accessor :city_name
  belongs_to :country
  belongs_to :city
  has_one :center

end


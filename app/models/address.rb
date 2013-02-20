class Address < ActiveRecord::Base
  attr_accessible :address_line, :city_id, :country_id

  belongs_to :country
  belongs_to :city
end

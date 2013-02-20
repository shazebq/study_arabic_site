class City < ActiveRecord::Base
  attr_accessible :country_id, :name
  has_many :addresses
  belongs_to :country
end

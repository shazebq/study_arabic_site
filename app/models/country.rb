class Country < ActiveRecord::Base
  attr_accessible :iso, :name
  has_many :users
  has_many :addresses
  has_many :cities
end

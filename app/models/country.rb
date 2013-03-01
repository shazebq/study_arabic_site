class Country < ActiveRecord::Base
  attr_accessible :iso, :name
  has_many :users
  has_many :addresses
  has_many :cities

  def teacher_profiles_in_country
    User.teachers.where(country_id: id).size
  end

  def centers_in_country
    Center.joins(:address).where("addresses.country_id" => id).size
  end
end

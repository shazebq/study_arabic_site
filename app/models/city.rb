class City < ActiveRecord::Base
  include PgSearch
  #multisearchable :against => :name
  attr_accessible :country_id, :name
  has_many :addresses
  belongs_to :country
end

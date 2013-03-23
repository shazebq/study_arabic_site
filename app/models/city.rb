class City < ActiveRecord::Base
  include PgSearch
  #multisearchable :against => :name
  attr_accessible :country_id, :name, :as => [:default, :admin] 
  has_many :addresses
  belongs_to :country
end

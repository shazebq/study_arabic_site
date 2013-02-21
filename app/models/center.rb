class Center < ActiveRecord::Base
  attr_accessible :address_id, :description, :email, :group_instruction, :housing_provided, :long_term, :name, :phone_number, 
                  :price_per_hour_group, :price_per_hour_private, :private_instruction, :program_length, :short_term, :total_price, 
                  :user_id, :website, :year_established, :address_attributes, :images_attributes

  belongs_to :address
  has_many :images, as: :imageable
  accepts_nested_attributes_for :address, :images
end

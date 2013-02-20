class Centers < ActiveRecord::Base
  attr_accessible :address_id, :description, :email, :group_instruction, :housing_provided, :long_term, :name, :phone_number, :price_per_hour_group, :price_per_hour_private, :private_instruction, :program_length, :short_term, :total_price, :user_id, :website, :year_established
end

class Center < ActiveRecord::Base
  attr_accessible :address_id, :description, :email, :group_instruction, :housing_provided, :long_term, :name, :phone_number, 
                  :price_per_hour_group, :price_per_hour_private, :private_instruction, :program_length, :short_term, :total_price, 
                  :user_id, :website, :year_established, :address_attributes, :images_attributes

  after_initialize :init

  belongs_to :address
  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :address, :images

  def init
    self.reviews_count ||= 0
  end
end

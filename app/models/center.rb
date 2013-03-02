class Center < ActiveRecord::Base
  include ReviewableScoping
  extend ReviewableScoping

  attr_accessible :address_id, :description, :email, :group_instruction, :housing_provided, :long_term, :name, :phone_number, 
                  :price_per_hour_group, :price_per_hour_private, :private_instruction, :program_length, :short_term, :total_price, 
                  :user_id, :website, :year_established, :address_attributes, :images_attributes

  after_initialize :init
  before_destroy :destroy_address 
  belongs_to :address
  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :address, :images

  scope :country_option, (lambda do |country_id| 
    if country_id == "all"
      where({})
    else
      joins(:address => :country).where("countries.id" => country_id)
    end
  end)

  def init
    self.reviews_count ||= 0
  end

  private
  def destroy_address
    self.address.delete
  end
end

#def self.country_option(country_id)
#    if country_id == "all"
#     where({}) 
#    else
#      TeacherProfile.select("teacher_profiles.*").
#                   joins("JOIN users ON users.profile_id = teacher_profiles.id").
#                   where("users.profile_type = ?", "TeacherProfile").
#                   where("users.country_id = ?", country_id)
#    end
#  end
#

class TeacherProfile < ActiveRecord::Base
  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :field_of_study, :university, :in_person, :online, :years_of_experience, :user_attributes, :specialties, :price_per_hour
end

# comments

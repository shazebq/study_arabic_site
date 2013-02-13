class TeacherProfile < ActiveRecord::Base
  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :education, :in_person, :online, :years_of_experience, :user_attributes, :specialities, :price_per_hour
end

# comments

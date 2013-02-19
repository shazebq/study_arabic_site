class Level < ActiveRecord::Base
  attr_accessible :description, :title, :years_of_study
  has_many :student_profiles
end

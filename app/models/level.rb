class Level < ActiveRecord::Base
  attr_accessible :description, :title, :years_of_study, :as => [:default, :admin] 
  has_many :student_profiles, dependent: :nullify # this will just set the foreign keys to null
  has_many :resources, dependent: :nullify
end

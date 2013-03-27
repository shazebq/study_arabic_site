class Degree < ActiveRecord::Base
  attr_accessible :name

  has_many :teacher_profiles
end

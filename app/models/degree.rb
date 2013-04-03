class Degree < ActiveRecord::Base
  include PgSearch
  attr_accessible :name

  has_many :teacher_profiles
end

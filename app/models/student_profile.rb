class StudentProfile < ActiveRecord::Base
  attr_accessible :level_id

  has_one :user, as: :profile
end

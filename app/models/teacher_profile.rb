class TeacherProfile < ActiveRecord::Base
  attr_accessible :education, :in_person, :online, :years_of_experience
end

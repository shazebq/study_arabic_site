class TeachersLanguage < ActiveRecord::Base
  attr_accessible :language_id, :teacher_profile_id
  
  belongs_to :teacher_profile
  belongs_to :language
end

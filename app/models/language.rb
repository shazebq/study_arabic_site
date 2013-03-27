class Language < ActiveRecord::Base
  attr_accessible :name

  has_many :teachers_languages
  has_many :teacher_profiles, through: :teacher_profiles_languages
end

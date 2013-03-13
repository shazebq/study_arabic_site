class StudentProfile < ActiveRecord::Base
  has_one :user, as: :profile, dependent: :destroy
  belongs_to :level
  accepts_nested_attributes_for :user
  attr_accessible :level_id, :user_attributes

  validates :level_id, presence: true
end

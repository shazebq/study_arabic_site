class TeacherProfile < ActiveRecord::Base
  include ReviewableScoping
  after_initialize :init
  has_one :user, as: :profile, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :field_of_study, :university, :in_person, :online, :years_of_experience, :user_attributes, :specialties, :price_per_hour

  scope :online_filter, where("online = true")
  scope :in_person_filter, where("in_person = true")
  
  # difficult to do this in active record with a polymorphic relationship to use find_by_sql instead
  # remember, in the last line, I'm adding the teacher profiles that don't have any reviews yet
  def self.order_by_average_rating(options = {})
      profiles = TeacherProfile.find_by_sql("SELECT teacher_profiles.*, AVG(reviews.rating) AS average_rating
                                FROM teacher_profiles
                                JOIN reviews ON reviews.reviewable_id = teacher_profiles.id
                                WHERE reviews.reviewable_type = 'TeacherProfile'
                                GROUP BY teacher_profiles.id
                                ORDER BY average_rating DESC") # + TeacherProfile.where(reviews_count: 0) 
  end

  def init
    self.reviews_count ||= 0
  end
end

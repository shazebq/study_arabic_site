class TeacherProfile < ActiveRecord::Base
  include ReviewableScoping
  after_initialize :init
  has_one :user, as: :profile, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :field_of_study, :university, :in_person, :online, :years_of_experience, :user_attributes, :specialties, :price_per_hour

  # difficult to do this in active record with a polymorphic relationship to use find_by_sql instead
  def self.order_by_average_rating
    TeacherProfile.find_by_sql("SELECT teacher_profiles.*, AVG(reviews.rating) AS average_rating
                                FROM teacher_profiles
                                JOIN reviews ON reviews.reviewable_id = teacher_profiles.id
                                WHERE reviews.reviewable_type = 'TeacherProfile'
                                GROUP BY teacher_profiles.id
                                ORDER BY average_rating DESC") + TeacherProfile.where(reviews_count: 0)
  end

  def init
    self.reviews_count ||= 0
  end
end

class TeacherProfile < ActiveRecord::Base
  include ReviewableScoping
  after_initialize :init
  has_one :user, as: :profile, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :field_of_study, :university, :in_person, :online, :years_of_experience, :user_attributes, :specialties, :price_per_hour

  scope :online_filter, where("online = true")
  scope :in_person_filter, where("in_person = true")
  scope :zero_review_records, where("reviews_count = 0")
  
  # difficult to do this in active record with a polymorphic relationship to use find_by_sql instead
  # remember, in the last line, I'm adding the teacher profiles that don't have any reviews yet
  def self.order_by_average_rating(options = {})
   profiles = TeacherProfile.select("teacher_profiles.*, AVG(reviews.rating) AS average_rating").
                  joins("JOIN reviews ON reviews.reviewable_id = teacher_profiles.id").
                  where("reviews.reviewable_type = ?", "TeacherProfile").
                  group("teacher_profiles.id").
                  order("average_rating DESC")
  end

  def init
    self.reviews_count ||= 0
  end

  def self.send_chain(my_array)
    my_array.inject(self) { |initial, additional| initial.send(additional) }
  end
end

class TeacherProfile < ActiveRecord::Base
  include ReviewableScoping
  extend ReviewableScoping
  after_initialize :init
  has_one :user, as: :profile, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :field_of_study, :university, :in_person, :online, :years_of_experience, :user_attributes, :specialties, :price_per_hour

  
  scope :price_option, (lambda do |price| 
    if price.blank?
      where("price_per_hour < ?", 0) 
    else
      where("price_per_hour <= ?", price) 
    end
  end)

  # takes a parameter which is an array of instruction options i.e. ["online", "in_person"]
  scope :instruction_option, (lambda do |attr_list| 
    t = TeacherProfile.arel_table 
    if attr_list == nil  # note in if no instruction option is selection, js returns nothing not even a blank string
      where(t[:online].eq("false").and(t[:in_person].eq("false"))) # this should always return nothing due to validation rules
    elsif attr_list.length == 2 
      where(t[:online].eq("true").or(t[:in_person].eq("true"))) # use metaprogramming to make this more general solution
    else
      where(t[attr_list[0].to_sym].eq("true"))
    end
  end)

  # chains the price_option and instruction option scopes to make things more compact in the controller
  def self.chain_scopes(my_hash) 
    [:instruction_option, :price_option, :country_option].inject(self) { |initial, additional| initial.send(additional, my_hash[additional]) }
  end
 
  # difficult to do this in active record with a polymorphic relationship to use find_by_sql instead
  # remember, in the last line, I'm adding the teacher profiles that don't have any reviews yet

  def self.country_option(country_id)
    if country_id == "all"
     where({}) 
    else
      TeacherProfile.select("teacher_profiles.*").
                   joins("JOIN users ON users.profile_id = teacher_profiles.id").
                   where("users.profile_type = ?", "TeacherProfile").
                   where("users.country_id = ?", country_id)
    end
  end

  def init
    self.reviews_count ||= 0
  end

end

# comments

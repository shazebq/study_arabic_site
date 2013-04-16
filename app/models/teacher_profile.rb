class TeacherProfile < ActiveRecord::Base
  include ApprovedScoping
  extend Searching
  include ReviewableScoping
  extend ReviewableScoping
  include PgSearch
  pg_search_scope :search, against: [:specialties, :field_of_study, :university],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {reviews: :content, user: [:first_name, :last_name, :bio],
                         languages: [:name], degree: [:name], city: [:name]} # needed so it searches associated records as well

  #multisearchable :against => [:specialties, :field_of_study, :university]

  after_initialize :init
  has_one :user, as: :profile, dependent: :destroy
  belongs_to :degree
  belongs_to :city
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :users, through: :reviews

  has_many :teachers_languages
  has_many :languages, through: :teachers_languages

  accepts_nested_attributes_for :user

  attr_accessor :city_name
  attr_accessible :field_of_study, :date_of_birth, :university, :in_person, :online, :years_of_experience,
                  :user_attributes, :specialties, :price_per_hour, :age, :other_education,
                  :employment_history, :degree_id, :language_ids, :gender, :skype_id, :city_id, :city_name, :as => [:default, :admin] 
  attr_accessible :approved, as: :admin

  validates :skype_id, length: { maximum: 30 }
  validates :city_name, presence: true, length: { maximum: 30 } 
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :gender, :format => { :with => /f|m/,
    :message => "must be m or f" }, reduce: true
  validates :specialties, presence: true, length: { maximum: 130 }
  validates :language_ids, presence: true
  validates :field_of_study, presence: true, length: { maximum: 30 }, reduce: true
  validates :university, length: { maximum: 30 } 
  validates :other_education, length: { maximum: 500 } 
  validates :years_of_experience, presence: true, numericality: { integer: true, less_than: 100 }, reduce: true  
  validates :employment_history, presence: true, length: { maximum: 500  }
  validates :price_per_hour, presence: true, numericality: { greater_than: 0.99, less_than: 100 }, reduce: true
  validates :in_person, :online, :inclusion => {:in => [true, false]}

  scope :include_associated, includes(:city, :user => :country)
  
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
 
  def self.country_option(country_id)
    if country_id == "all" || country_id.blank?
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

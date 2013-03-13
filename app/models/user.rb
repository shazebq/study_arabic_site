class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include PgSearch 
  #multisearchable :against => [:first_name, :last_name, :bio]

  before_destroy :destroy_user_profile
  has_many :forum_posts
  has_many :answers
  has_many :resources
  has_many :reviews
  has_one :image, as: :imageable, dependent: :destroy
  belongs_to :profile, polymorphic: true
  belongs_to :country
  accepts_nested_attributes_for :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :bio, :country_id, :image_attributes, :skype_id

  validates :first_name, :last_name, :bio, :country_id, presence: true 
  validates :first_name, :last_name, :skype_id, length: { maximum: 65 }   
  validates :bio, length: { maximum: 2000 }

  scope :teachers, where(profile_type: "TeacherProfile")
  scope :students, where(profile_type: "StudentProfile")

  private
  def destroy_user_profile
    self.profile.delete
  end
end


#comment

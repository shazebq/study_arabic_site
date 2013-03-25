class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include PgSearch 
  #multisearchable :against => [:first_name, :last_name, :bio]

  before_destroy :destroy_user_profile
  has_many :forum_posts, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :centers
  has_many :articles
  has_many :comments

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy  

  has_one :image, as: :imageable, dependent: :destroy

  belongs_to :profile, polymorphic: true
  belongs_to :country
  accepts_nested_attributes_for :image

  after_initialize :init

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :bio, :country_id, :image_attributes, :skype_id, :as => [:default, :admin] 
  attr_accessible :admin, as: :admin

  validates :first_name, presence: true, length: { maximum: 30 }, reduce: true
  validates :last_name, presence: true, length: { maximum: 30 }, reduce: true
  validates :bio, presence: true, length: { maximum: 1000 }, reduce: true

  scope :teachers, where(profile_type: "TeacherProfile")
  scope :students, where(profile_type: "StudentProfile")

  REP_POINTS_HASH = { comment: 1, forum_post: 2, answer: 4, resource: 4, center: 4, review: 2, up_vote: 2, down_vote: -2}

  def add_rep_points(item_added)
    logger.fatal "Terminating application"
    self.reputation = self.reputation + REP_POINTS_HASH[item_added]
    self.save
  end

  def init
    self.reputation ||= 0
  end
   
  private
  def destroy_user_profile
    self.profile.delete
  end
end


#comments

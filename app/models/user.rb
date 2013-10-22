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

  has_many :votes, dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy  

  has_one :image, as: :imageable, dependent: :destroy
  has_many :images

  has_many :notifications, foreign_key: "recipient_id", dependent: :destroy

  belongs_to :profile, polymorphic: true
  belongs_to :country
  accepts_nested_attributes_for :image

  after_initialize :init

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, 
                  :last_name, :username, :bio, :country_id, :image_attributes, :provider, :uid, :name, :as => [:default, :admin] 
  # only an admin can change the admin attribute
  attr_accessible :admin, as: :admin

  # virtual attribute
  attr_accessor :has_teacher_profile

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  #validates :username, presence: true, length: { maximum: 30 }, uniqueness: true 
  validates :country_id, numericality: { integer: true }, reduce: true, :if => :is_teacher?
  validates :bio, length: { maximum: 1000 }, :if => :is_teacher?
  validates :bio, length: { maximum: 1000 }, :allow_blank => :true, :if => :is_student?

  scope :teachers, where(profile_type: "TeacherProfile")
  scope :students, where(profile_type: "StudentProfile")

  REP_POINTS_HASH = { "ForumPost" => 2, "Article" => 4, "Answer" => 4, "Resource" => 4 }
  
  delegate :unread_messages, :to => :received_messages

  def is_teacher?
    self.has_teacher_profile
  end

  def is_student?
    true if self.has_teacher_profile != true
  end

  def send_on_create_confirmation_instructions
    Devise::Mailer.delay.confirmation_instructions(self)
  end
  
  def send_reset_password_instructions
    generate_reset_password_token! if should_generate_reset_token?
    Devise::Mailer.delay.reset_password_instructions(self)
  end

  def send_unlock_instructions
    Devise::Mailer.delay.unlock_instructions(self)
  end

  def add_rep_points(item)
    self.reputation = self.reputation + REP_POINTS_HASH[item]
    self.save
  end

  def subtract_rep_points(item)
    self.reputation = self.reputation - REP_POINTS_HASH[item]
    self.save
  end

  def voted_up?(voteable)
    if self.votes.where(voteable_id: voteable.id, voteable_type: voteable.class.name).any?
      true
    else
      false
    end
  end

  def init
    self.reputation ||= 0
  end

  def to_param
    return "#{id}-#{first_name.parameterize}-#{last_name.parameterize}" if self.profile_type == "TeacherProfile"
    return "#{id}-#{display_name.parameterize}" if self.profile_type == "StudentProfile"
  end

  def new_notifications
    self.notifications.only_new
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create!( first_name:auth.extra.raw_info.first_name,
                          last_name:auth.extra.raw_info.last_name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                        )

    end
    add_student_profile_to_new_user(user)
    user
  end 

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    data = auth.info
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
        user = User.create(first_name: data["first_name"],
                           last_name: data["last_name"],
                           provider: auth.provider,
                           uid: auth.uid,
                           email: data["email"],
                           password: Devise.friendly_token[0,20]
                          )
    end
    add_student_profile_to_new_user(user)
    user
  end

  def self.add_student_profile_to_new_user(user)
    if user.persisted?
        # create student profile
        student_profile = StudentProfile.new
        student_profile.user = user
        student_profile.save!
    end
  end

  def confirmation_required?
    if self.provider?
      false
    else
      super
    end
  end

  def display_name
    if self.username.blank?
      "#{self.first_name.capitalize} #{self.last_name[0].capitalize}"
    else
      self.username
    end
  end

  private
  def destroy_user_profile
    self.profile.delete
  end
end

#comments

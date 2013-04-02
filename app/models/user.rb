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

  belongs_to :profile, polymorphic: true
  belongs_to :country
  accepts_nested_attributes_for :image

  after_initialize :init

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, 
                  :last_name, :username, :bio, :country_id, :image_attributes, :as => [:default, :admin] 
  attr_accessible :admin, as: :admin

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :username, presence: true, length: { maximum: 30 }, uniqueness: true 
  validates :country_id, presence: true, numericality: { integer: true }, reduce: true
  validates :bio, presence: true, length: { maximum: 1000 }, reduce: true

  scope :teachers, where(profile_type: "TeacherProfile")
  scope :students, where(profile_type: "StudentProfile")

  REP_POINTS_HASH = { comment: 1, forum_post: 2, answer: 4, resource: 4, center: 4, review: 2, up_vote: 2, down_vote: -2}

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



  def add_rep_points(item_added)
    logger.fatal "Terminating application"
    self.reputation = self.reputation + REP_POINTS_HASH[item_added]
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
   
  private
  def destroy_user_profile
    self.profile.delete
  end
end


#comments

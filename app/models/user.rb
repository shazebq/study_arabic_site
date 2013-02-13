class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  before_destroy :destroy_user_profile
  has_many :forum_posts
  has_many :answers
  has_many :resources
  has_one :image, as: :imageable
  belongs_to :profile, polymorphic: true
  belongs_to :country

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :bio, :country_id

  private
  def destroy_user_profile
    self.profile.delete
  end
end


#commentss

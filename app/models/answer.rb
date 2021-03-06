class Answer < ActiveRecord::Base
  include Voting
  #include PgSearch
  #multisearchable :against => :content
  after_initialize :init
  attr_accessible :content, :forum_post_id, :user_id, :as => [:default, :admin]

  belongs_to :user
  belongs_to :forum_post, counter_cache: true
  has_many :votes, :as => :voteable

  has_many :comments, :as => :commentable, dependent: :destroy

  has_many :responsible_party_notifications, class_name: "Notification", :as => :responsible_party_object, dependent: :destroy
  has_many :recipient_notifications, class_name: "Notification", :as => :recipient_object, dependent: :destroy

  validates :content, presence: true, length: { maximum: 10000 } 
  validates :forum_post_id, presence: true

  # orders by number of votes
  scope :by_votes, order("votes_count desc, id desc")
  scope :saved_records, where("ID IS NOT ?", nil)

  def init
    self.votes_count ||= 0
  end

end





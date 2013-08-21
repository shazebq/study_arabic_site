class ForumPost < ActiveRecord::Base
  extend Searching
  include Voting
  include Scoping
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {categories: :name, answers: :content} # needed so it searches associated records as well
  #multisearchable :against => [:title, :content]

  attr_accessible :content, :title, :user_id, :views_count, :votes_count, :answers_count, :category_ids, :as => [:default, :admin] 
  after_initialize :init

  belongs_to :user

  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  has_many :categories, through: :categories_categorizables

  has_many :votes, as: :voteable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :users, through: :answers

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :recipient_notifications, class_name: "Notification", :as => :recipient_object, dependent: :destroy

  validates :title, :content, :category_ids, presence: true

  validates :title, length: { maximum: 130 }
  validates :content, length: {maximum: 2000 }

  SCOPES = ["most_recent", "most_views", "most_votes", "most_answers", "unanswered"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.answers_count ||= 0
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  # remove current answerer and keep it unique (to send email to all others who have answered the question)
  def answerers_list(opts = {})
    answerers = self.answers.map { |answer| answer.user }
    answerers.delete(opts[:current_answerer]) if opts[:current_answerer]
    answerers.delete(nil) # due to new record in controller
    answerers
  end

end

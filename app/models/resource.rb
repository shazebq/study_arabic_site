class Resource < ActiveRecord::Base
  include ApprovedScoping
  extend Searching
  include Voting
  include Scoping
  include PgSearch
  pg_search_scope :search, against: [:title, :description],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {categories: :name, reviews: :content} # needed so it searches associated records as well
  #multisearchable :against => [:title, :description]

  after_initialize :init
  attr_accessible :description, :level_id, :difficulty_level, :downloads_count, :title, 
                  :user_id, :views_count, :votes_count, :resource_file, :category_ids, :as => [:default, :admin] 

  # normally, in a regular (non polymorph join), you wouldn't have the as: option
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  # just like regular join table
  has_many :categories, through: :categories_categorizables
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  has_many :users, through: :reviews

  belongs_to :user
  belongs_to :level

  validates :title, :description, :category_ids, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :level_id, presence: true;

  SCOPES = ["most_recent", "most_views", "most_votes", "most_downloads"]

  mount_uploader :resource_file, ResourceFileUploader 

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.downloads_count ||= 0
    self.reviews_count ||= 0
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def process_only_valid
    unless self.valid?
      return false
    end
  end

  # for validating carrierwave_direct files which are uploaded to s3
  def self.validate_file_type(file_name)
    begin
      extension = file_name.split(".")[-1]
      return false if extension.size <= 1
    rescue
      return false
    end

    if %w(jpg jpeg png pdf doc docx txt).include?(extension)
      true
    else
      false
    end
  end

end

# validates_attachment_content_type :uploaded_file, :content_type =>['application/pdf']

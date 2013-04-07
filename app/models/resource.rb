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
  attr_accessible :description, :level_id, :difficulty_level, :downloads_count, :title, :user_id, :views_count, :votes_count, :resource_file, :category_ids, :as => [:default, :admin] 

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

  # need this for paper clip
  has_attached_file :resource_file, styles: lambda { |attachment|
                                              if attachment.instance.resource_file_content_type != "application/msword" && attachment.instance.resource_file_content_type != "text/plain"
                                                { :thumb => ["235x305#", :png] }
                                              else
                                                {}
                                              end
                                            },
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => ENV["AWS_BUCKET"],
                        :access_key_id => ENV["AWS_ACCESS_KEY_ID"],
                        :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
                    },
                    :url => "/:class/:attachment/:id_partition/:style/:filename",
                    # not the standard U.S. one so it must be specified
                    s3_host_name: "s3-us-west-2.amazonaws.com"

                                           

  validates_attachment_content_type(:resource_file, content_type: ["image/jpeg", "image/jpg", "application/pdf", "application/msword", "text/plain"])
  validates_attachment_size(:resource_file, :less_than => 4.megabytes) 

  before_post_process :process_only_valid
  validates :title, :description, :category_ids, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :level_id, presence: true;

  SCOPES = ["most_recent", "most_views", "most_votes", "most_downloads"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.downloads_count ||= 0
    self.reviews_count ||= 0
  end

  def process_only_valid
    unless self.valid?
      return false
    end
  end
end

# validates_attachment_content_type :uploaded_file, :content_type =>['application/pdf']

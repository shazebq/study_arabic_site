class Resource < ActiveRecord::Base
  include Voting
  include Scoping
  after_initialize :init
  attr_accessible :description, :difficulty_level, :downloads_count, :title, :user_id, :views_count, :votes_count, :resource_file, :category_ids

  # normally, in a regular (non polymorph join), you wouldn't have the as: option
  has_many :categories_categorizables, as: :categorizable, dependent: :destroy
  # just like regular join table
  has_many :categories, through: :categories_categorizables
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  belongs_to :user

  # need this for paper clip
  has_attached_file :resource_file, styles: lambda { |attachment|
                                              if attachment.instance.resource_file_content_type != "application/msword" && attachment.instance.resource_file_content_type != "text/plain"
                                                { :thumb => ["550x425", :png], :medium => ["1100x8500", :png] }
                                              else
                                                {}
                                              end
                                            },
                                              :default_url => "/images/rails.png"

  validates_attachment_content_type(:resource_file, content_type: ["image/jpeg", "image/jpg", "application/pdf", "application/msword", "text/plain"])

  validates :title, :description, :category_ids, presence: true

  validates :title, length: { maximum: 65 }
  validates :description, length: { maximum: 5000 }

  SCOPES = ["most_recent", "most_views", "most_votes", "most_downloads"]

  def init
    self.views_count ||= 0
    self.votes_count ||= 0
    self.downloads_count ||= 0
  end

end


# validates_attachment_content_type :uploaded_file, :content_type =>['application/pdf']

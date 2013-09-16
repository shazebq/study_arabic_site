class Center < ActiveRecord::Base
  include ReviewableScoping
  include ApprovedScoping
  extend ReviewableScoping
  extend Searching
  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {reviews: [:title, :content]} # needed so it searches associated records as well
  #multisearchable :against => [:name, :description]

  attr_accessible :address_id, :description, :email, :group_instruction, :housing_provided, :long_term, :name, :phone_number, 
                  :price_per_hour_group, :price_per_hour_private, :private_instruction, :program_length, :short_term, :total_price, 
                  :user_id, :website, :year_established, :address_attributes, :images_attributes, :as => [:default, :admin] 
  attr_accessible :approved, as: :admin

  after_initialize :init
  before_destroy :destroy_address 
  belongs_to :address
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :users, through: :reviews
  accepts_nested_attributes_for :address, :images

  before_validation :add_http

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1500 } 
  #validates :website, url: true
  validates :email, email_format: true 
  validates :phone_number, length: { maximum: 15 }
  validates :year_established, allow_blank: true, numericality: { integer: true }, length: { is: 4 }
  validates :price_per_hour_private, :price_per_hour_group, allow_blank: true,
            numericality: { greater_than: 0, less_than: 100 }
  validates :total_price, allow_blank: true, numericality: { greater_than: 0, less_than: 100000 }

  scope :country_option, (lambda do |country_id| 
    if country_id == "all"
      where({})
    else
      joins(:address => :country).where("countries.id" => country_id)
    end
  end)

  def init
    self.reviews_count ||= 0
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  # grabs only the attributes that are needed for the maps
  def self.get_mappable_attributes(centers)
    centers.as_json(:only => [:name, :id], 
                    :include => 
                      {:address => 
                        { 
                          :only => [:latitude, :longitude], 
                          :include => 
                            { :country => { :only => :name },
                              :city => { :only => :name }
                            } 
                        } 
                      },
                    )
  end

  private
  def destroy_address
    self.address.delete
  end

  def add_http
    unless self.website[/^http:\/\//] || self.website[/^https:\/\//]
      self.website = 'http://' + self.website
    end
  end



end

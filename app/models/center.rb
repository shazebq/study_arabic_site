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

  validates :name, :description, presence: true

  validates :name, length: { maximum: 65 }
  validates :description, length: { maximum: 2000 }

  validates :price_per_hour_private, :price_per_hour_group, allow_blank: true,
            numericality: { greater_than: 0, less_than: 100 }

  validates :total_price, allow_blank: true, numericality: { greater_than: 0, less_than: 100000 }
  validates :year_established, allow_blank: true, numericality: { integer: true }, length: { is: 4 }

  validates :email, email_format: true 
  validates :website, url: true


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

  private
  def destroy_address
    self.address.delete
  end
end

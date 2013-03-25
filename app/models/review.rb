class Review < ActiveRecord::Base
  include PgSearch
  #multisearchable :against => [:title, :content]

  attr_accessible :content, :rating, :reviewable_id, :reviewable_type, :title, :user_id, :as => [:default, :admin] 

  belongs_to :user
  belongs_to :reviewable, polymorphic: true, counter_cache: true

  validates :title, presence: true, length: { maximum: 65 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_blank: true }
end

# comment

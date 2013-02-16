class Review < ActiveRecord::Base
  attr_accessible :content, :rating, :reviewable_id, :reviewable_type, :title, :user_id

  belongs_to :user
  belongs_to :reviewable, polymorphic: true, counter_cache: true

  validates :title, :content, presence: true

  validates :title, length: { maximum: 65 }
  validates :content, length: { maximum: 5000 }

end

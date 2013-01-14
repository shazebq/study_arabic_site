class Review < ActiveRecord::Base
  attr_accessible :content, :rating, :reviewable_id, :reviewable_type, :title, :user_id

  belongs_to :user
  belongs_to :resource, polymorphic: true, counter_cache: true
end

class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id, :voteable_type, :as => [:default, :admin] 

  belongs_to :voteable, polymorphic: true, counter_cache: true

  validates_uniqueness_of :user_id, :scope => [:voteable_id, :voteable_type]
end

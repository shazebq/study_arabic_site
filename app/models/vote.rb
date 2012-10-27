class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id, :voteable_type

  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :user_id, :scope => [:voteable_id, :voteable_type]
end

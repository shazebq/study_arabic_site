class Views < ActiveRecord::Base
  attr_accessible :user_id, :viewable_id, :viewable_type

  belongs_to :viewable, polymorphic: true

  validates_uniqueness_of :user_id, :scope => [:viewable_id, :viewable_type]
end

class View < ActiveRecord::Base
  attr_accessible :viewable_id, :viewable_type, :ip_address, :session_id, :as => [:default, :admin] 

  belongs_to :viewable, polymorphic: true, counter_cache: true

  validates_uniqueness_of :ip_address, :scope => [:viewable_id, :viewable_type, :session_id]
end

class Photo < ActiveRecord::Base
  attr_accessible :photo_file, :photographable_id, :photographable_type, :photo, :as => [:default, :admin] 
  belongs_to :photographable, polymorphic: true

  mount_uploader :photo_file, PhotoFileUploader 
end

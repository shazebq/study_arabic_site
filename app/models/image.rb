class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type

  belongs_to :imageable, polymorphic: true
  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "250x250>", :thumb => "100x100>" } 
end

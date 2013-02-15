class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type

  belongs_to :imageable, polymorphic: true
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "250x250>", :thumb => "100x100>" }
end

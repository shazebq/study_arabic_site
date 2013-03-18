class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :photo

  belongs_to :imageable, polymorphic: true
  has_attached_file :photo, :styles => { :original => "500x400#", :large => "275x220#", :medium => "175x140#", :thumb => "100x80#" }

  #has_attached_file :photo, :styles => lambda { |attachment| attachment.instance.choose_styles }
  
  # attempt to save images conditionally, but the attributes of the associated model are not
  # available in the paperclip processor.
  #def choose_styles
    #if self.imageable_type == "Article"
    #  { :large => "275x220#", :medium => "175x140#", :thumb => "100x80#" } 
    #else
    #  { :medium => "175x140#", :thumb => "100x80#" } 
    #end 
  #end
end

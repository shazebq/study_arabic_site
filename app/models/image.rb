class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :photo, :as => [:default, :admin] 

  belongs_to :imageable, polymorphic: true
  has_attached_file :photo, :styles => { :original => "500x400#", :large => "275x220#", :medium => "175x140#", :thumb => "100x80#" }

  #validates_attachment_presence :photo, :message => 'you need an image!'

  #validates_attachment_content_type(:photo, content_type: ["image/jpeg", "image/jpg"])

  #validates :photo, :attachment_presence => true
  #validates_with AttachmentPresenceValidator, :attributes => :photo

  validates_attachment :photo, :presence => true,
                       :content_type => { :content_type => ["image/jpeg", "image/jpg"] }

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

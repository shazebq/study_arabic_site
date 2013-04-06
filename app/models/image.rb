class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :photo, :as => [:default, :admin] 
  belongs_to :imageable, polymorphic: true
  belongs_to :user
  has_attached_file :photo, :styles => { :original => "500x400#", :large => "275x220#", :medium => "175x140#", :thumb => "100x80#" },
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => ENV["AWS_BUCKET"],
                        :access_key_id => ENV["AWS_ACCESS_KEY_ID"],
                        :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
                    },
                    :url => "/:class/:attachment/:id_partition/:style/:filename",
                    s3_host_name: "s3-us-west-2.amazonaws.com"


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

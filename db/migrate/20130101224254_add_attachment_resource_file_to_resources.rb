class AddAttachmentResourceFileToResources < ActiveRecord::Migration
  def self.up
    change_table :resources do |t|
      t.attachment :resource_file
    end
  end

  def self.down
    drop_attached_file :resources, :resource_file
  end
end

class AddResourceFileToResources < ActiveRecord::Migration
  def change
    add_column :resources, :resource_file, :string
  end
end

class AddLevelIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :level_id, :integer
  end
end

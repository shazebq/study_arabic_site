class RemoveUserIdFromViews < ActiveRecord::Migration
  def up
    remove_column :views, :user_id
  end

  def down
    add_column :views, :user_id, :integer
  end
end

class RemoveVerbFromNotifications < ActiveRecord::Migration
  def up
    remove_column :notifications, :verb
  end

  def down
    add_column :notifications, :verb, :string
  end
end

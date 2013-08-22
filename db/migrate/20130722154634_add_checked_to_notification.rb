class AddCheckedToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :checked, :boolean
  end
end

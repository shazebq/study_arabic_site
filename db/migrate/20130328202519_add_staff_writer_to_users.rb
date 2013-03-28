class AddStaffWriterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :staff_writer, :boolean
  end
end

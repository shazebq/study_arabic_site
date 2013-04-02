class RemoveSkypdIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :skype_id
  end

  def down
    add_column :users, :skype_id, :string
  end
end

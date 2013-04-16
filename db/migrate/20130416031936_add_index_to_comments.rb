class AddIndexToComments < ActiveRecord::Migration
  def up 
    add_index :comments, :user_id
  end

  def down
    remove_index :comments, :user_id
  end
end

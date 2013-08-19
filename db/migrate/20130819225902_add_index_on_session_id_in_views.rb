# because the uniqueness of session_id and ip_address are checked before the creation of every view 
class AddIndexOnSessionIdInViews < ActiveRecord::Migration
  def up
    add_index :views, :session_id
    add_index :views, :ip_address
  end

  def down
    remove_index :views, :session_id
    remove_index :views, :ip_address
  end
end

class AddSessionIdToViews < ActiveRecord::Migration
  def change
    add_column :views, :session_id, :string
  end
end

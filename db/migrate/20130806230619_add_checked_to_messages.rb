class AddCheckedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :checked, :boolean
  end
end

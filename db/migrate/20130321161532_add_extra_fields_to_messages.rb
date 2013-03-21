class AddExtraFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_delete, :boolean
    add_column :messages, :recipient_delete, :boolean
  end
end

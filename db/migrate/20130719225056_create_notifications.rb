class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :responsible_party_id
      t.integer :recipient_object_id
      t.string :recipient_object_type
      t.string :responsible_party_object_id
      t.string :responsible_party_object_type
      t.string :verb

      t.timestamps
    end
  end
end

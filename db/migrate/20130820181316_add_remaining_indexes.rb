class AddRemainingIndexes < ActiveRecord::Migration
  def up
    # because of unique constrains on views and votes
    add_index :views, [:ip_address, :viewable_id, :viewable_type, :session_id], :name => "views_unique_index"
    add_index :votes, [:user_id, :voteable_id, :voteable_type], :name => "votes_unique_index"

    add_index :users, [:id, :admin]
    add_index :users, [:id, :staff_writer]

    add_index :notifications, [:recipient_id, :checked]

    add_index :centers, :approved

    add_index :messages, [:sender_id, :sender_delete]
    add_index :messages, [:recipient_id, :recipient_delete]
    add_index :messages, [:recipient_id, :checked]
  end

  def down
    remove_index :views, [:ip_address, :viewable_type, :viewable_id, :session_id]
    remove_index :votes, [:user_id, :voteable_id, :voteable_type]

    remove_index :users, [:id, :admin]
    remove_index :users, [:id, :staff_writer]

    remove_index :notifications, [:recipient_id, :checked]

    remove_index :centers, :approved

    remove_index :messages, [:sender_id, :sender_delete]
    remove_index :messages, [:recipient_id, :recipient_delete]
    remove_index :messages, [:recipient_id, :checked]
  end
end

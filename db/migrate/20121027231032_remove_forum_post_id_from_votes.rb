class RemoveForumPostIdFromVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :forum_post_id
  end

  def down
    add_column :votes, :forum_post_id, :integer
  end
end

class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :forum_post_id

      t.timestamps
    end
  end
end

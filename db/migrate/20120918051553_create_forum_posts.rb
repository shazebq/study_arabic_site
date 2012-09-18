class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.text :title
      t.text :content
      t.integer :views_count
      t.integer :votes_count
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end

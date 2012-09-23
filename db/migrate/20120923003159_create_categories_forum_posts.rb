class CreateCategoriesForumPosts < ActiveRecord::Migration
  def change
    create_table :categories_forum_posts do |t|
      t.integer :category_id
      t.integer :forum_post_id

      t.timestamps
    end
  end
end

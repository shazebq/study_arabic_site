class DropCategoriesForumPostsTable < ActiveRecord::Migration
  def up
    drop_table :categories_forum_posts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

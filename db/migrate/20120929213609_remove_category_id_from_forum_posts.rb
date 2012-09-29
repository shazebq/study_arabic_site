class RemoveCategoryIdFromForumPosts < ActiveRecord::Migration
  def up
    remove_column :forum_posts, :category_id
  end

  def down
    add_column :forum_posts, :category_id, :integer
  end
end

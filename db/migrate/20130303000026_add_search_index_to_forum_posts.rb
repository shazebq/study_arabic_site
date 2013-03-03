class AddSearchIndexToForumPosts < ActiveRecord::Migration
  def up 
    execute "create index forum_posts_title on forum_posts using gin(to_tsvector('english', title))"
    execute "create index forum_posts_content on forum_posts using gin(to_tsvector('english', content))"
  end

  def down
    execute "drop index forum_posts_title"
    execute "drop index forum_posts_content" 
  end
end

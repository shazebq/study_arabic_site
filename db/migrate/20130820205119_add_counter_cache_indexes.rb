class AddCounterCacheIndexes < ActiveRecord::Migration
  def up
    add_index :articles, :views_count
    add_index :articles, :votes_count

    add_index :forum_posts, :answers_count
    add_index :forum_posts, :views_count
    add_index :forum_posts, :votes_count

    add_index :resources, :downloads_count
    add_index :resources, :views_count
    add_index :resources, :votes_count

    add_index :centers, :reviews_count

    add_index :teacher_profiles, :reviews_count
  end

  def down
    remove_index :articles, :views_count
    remove_index :articles, :votes_count

    remove_index :forum_posts, :answers_count
    remove_index :forum_posts, :views_count
    remove_index :forum_posts, :votes_count

    remove_index :resources, :downloads_count
    remove_index :resources, :views_count
    remove_index :resources, :votes_count

    remove_index :centers, :reviews_count
    
    remove_index :teacher_profiles, :reviews_count
  end
end

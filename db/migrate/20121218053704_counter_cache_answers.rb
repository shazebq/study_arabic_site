class CounterCacheAnswers < ActiveRecord::Migration
  def self.up
    add_column :forum_posts, :answers_count, :integer, :default => 0

    # set the default value if creating after the items already have votes associated with them
    ForumPost.find_each do |post|
      post.update_attribute(:answers_count, post.answers.count)
      post.save
    end

  end

  def self.down
    remove_column :forum_posts, :answers_count
  end
end

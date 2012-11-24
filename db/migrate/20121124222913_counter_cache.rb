class CounterCache < ActiveRecord::Migration
  def self.up
    add_column :answers, :votes_count, :integer, :default => 0

    # set the default value if creating after the items already have votes associated with them
    Answer.find_each do |answer|
      answer.update_attribute(:votes_count, answer.votes.length)
      answer.save
    end

    ForumPost.find_each do |forum_post|
      forum_post.update_attribute(:votes_count, forum_post.votes.length)
      forum_post.save

      forum_post.update_attribute(:views_count, forum_post.views.length)
      forum_post.save
    end
  end

  def self.down
    remove_column :answers, :votes_count
  end
end

class RemoveVotesCountFromAnswers < ActiveRecord::Migration
  def up
    remove_column :answers, :votes_count
  end

  def down
    add_column :answers, :votes_count, :integer
  end
end

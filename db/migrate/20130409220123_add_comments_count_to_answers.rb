class AddCommentsCountToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :comments_count, :integer
  end
end

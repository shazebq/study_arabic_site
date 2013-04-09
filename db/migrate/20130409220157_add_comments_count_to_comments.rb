class AddCommentsCountToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comments_count, :integer
  end
end

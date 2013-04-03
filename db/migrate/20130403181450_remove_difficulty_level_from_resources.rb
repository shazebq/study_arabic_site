class RemoveDifficultyLevelFromResources < ActiveRecord::Migration
  def up
    remove_column :resources, :difficulty_level
  end

  def down
    add_column :resources, :difficulty_level, :integer
  end
end

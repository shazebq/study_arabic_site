class RemoveAgeFromTeacherProfiles < ActiveRecord::Migration
  def up
    remove_column :teacher_profiles, :age
  end

  def down
    add_column :teacher_profiles, :age, :integer
  end
end

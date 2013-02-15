class RemoveEducationFromTeacherProfiles < ActiveRecord::Migration
  def up
    remove_column :teacher_profiles, :education
  end

  def down
    add_column :teacher_profiles, :education, :text
  end
end

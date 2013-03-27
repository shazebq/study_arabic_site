class RemoveDegreeFromTeacherProfiles < ActiveRecord::Migration
  def up
    remove_column :teacher_profiles, :degree
  end

  def down
    add_column :teacher_profiles, :degree, :text
  end
end

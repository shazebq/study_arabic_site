class RemoveLanguagesSpokenFromTeacherProfiles < ActiveRecord::Migration
  def up
    remove_column :teacher_profiles, :languages_spoken
  end

  def down
    add_column :teacher_profiles, :languages_spoken, :text
  end
end

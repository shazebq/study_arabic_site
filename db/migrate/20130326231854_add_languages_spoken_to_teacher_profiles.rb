class AddLanguagesSpokenToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :languages_spoken, :text
  end
end

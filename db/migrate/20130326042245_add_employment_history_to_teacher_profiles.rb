class AddEmploymentHistoryToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :employment_history, :text
  end
end

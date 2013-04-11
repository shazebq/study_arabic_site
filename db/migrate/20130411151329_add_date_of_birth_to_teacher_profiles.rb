class AddDateOfBirthToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :date_of_birth, :date
  end
end

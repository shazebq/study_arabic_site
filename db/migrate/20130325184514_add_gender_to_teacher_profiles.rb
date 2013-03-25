class AddGenderToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :gender, :string
  end
end

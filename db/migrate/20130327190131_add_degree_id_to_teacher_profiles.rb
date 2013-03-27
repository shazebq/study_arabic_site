class AddDegreeIdToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :degree_id, :integer
  end
end

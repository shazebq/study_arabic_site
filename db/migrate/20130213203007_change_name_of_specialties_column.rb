class ChangeNameOfSpecialtiesColumn < ActiveRecord::Migration
  def change
    rename_column :teacher_profiles, :specialties, :specialties
  end
end

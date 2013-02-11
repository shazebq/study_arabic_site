class CreateStudentProfiles < ActiveRecord::Migration
  def change
    create_table :student_profiles do |t|
      t.integer :level_id

      t.timestamps
    end
  end
end

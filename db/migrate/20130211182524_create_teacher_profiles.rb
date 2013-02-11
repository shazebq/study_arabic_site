class CreateTeacherProfiles < ActiveRecord::Migration
  def change
    create_table :teacher_profiles do |t|
      t.text :education
      t.boolean :online
      t.boolean :in_person
      t.integer :years_of_experience

      t.timestamps
    end
  end
end

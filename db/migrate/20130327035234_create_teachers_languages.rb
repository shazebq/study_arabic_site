class CreateTeachersLanguages < ActiveRecord::Migration
  def change
    create_table :teachers_languages do |t|
      t.integer :language_id
      t.integer :teacher_profile_id

      t.timestamps
    end
  end
end

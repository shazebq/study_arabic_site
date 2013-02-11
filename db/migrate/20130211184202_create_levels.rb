class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.text :title
      t.text :description
      t.integer :years_of_study

      t.timestamps
    end
  end
end

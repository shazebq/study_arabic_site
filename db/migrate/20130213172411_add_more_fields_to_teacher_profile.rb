class AddMoreFieldsToTeacherProfile < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :price_per_hour, :decimal, precision: 5, scale: 2
    add_column :teacher_profiles, :specialties, :text
  end
end

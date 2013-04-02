class AddCityIdToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :city_id, :integer
  end
end

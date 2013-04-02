class AddSkypeIdToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :skype_id, :string
  end
end

class AddEducationRelatedFieldsToTeacherProfile < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :university, :text
    add_column :teacher_profiles, :field_of_study, :text
  end
end

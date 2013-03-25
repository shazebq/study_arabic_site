class AddAdditionalFieldsToTeachProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :age, :integer
    add_column :teacher_profiles, :degree, :text
    add_column :teacher_profiles, :other_education, :text
  end
end

class AddApprovedColumnToModels < ActiveRecord::Migration
  def change
    add_column :answers, :approved, :boolean
    add_column :articles, :approved, :boolean
    add_column :centers, :approved, :boolean
    add_column :comments, :approved, :boolean
    add_column :forum_posts, :approved, :boolean
    add_column :resources, :approved, :boolean
    add_column :reviews, :approved, :boolean
    add_column :teacher_profiles, :approved, :boolean
    add_column :student_profiles, :approved, :boolean
  end
end


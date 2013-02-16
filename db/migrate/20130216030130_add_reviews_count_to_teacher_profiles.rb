class AddReviewsCountToTeacherProfiles < ActiveRecord::Migration
  def change
    add_column :teacher_profiles, :reviews_count, :integer
  end
end

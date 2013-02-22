class AddReviewsCountToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :reviews_count, :integer
  end
end

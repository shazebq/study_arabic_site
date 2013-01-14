class AddReviewsCountToResources < ActiveRecord::Migration
  def change
    add_column :resources, :reviews_count, :integer
  end
end

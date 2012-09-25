class AddCategoryParentIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_parent_id, :integer
  end
end

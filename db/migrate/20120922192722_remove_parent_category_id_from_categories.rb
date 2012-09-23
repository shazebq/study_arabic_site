class RemoveParentCategoryIdFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :parent_category_id
  end

  def down
    add_column :categories, :parent_category_id, :integer
  end
end

class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :categories, :parent, :parent_category_id
  end
end

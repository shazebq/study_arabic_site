class CreateCategoriesCategorizables < ActiveRecord::Migration
  def change
    create_table :categories_categorizables do |t|
      t.integer :category_id
      t.integer :categorizable_id
      t.string :categorizable_type

      t.timestamps
    end
  end
end

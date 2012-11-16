class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :viewable_id
      t.string :viewable_type

      t.timestamps
    end
  end
end

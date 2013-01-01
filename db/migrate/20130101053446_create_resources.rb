class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :title
      t.text :description
      t.integer :downloads_count
      t.integer :views_count
      t.integer :votes_count
      t.integer :difficulty_level
      t.integer :user_id

      t.timestamps
    end
  end
end

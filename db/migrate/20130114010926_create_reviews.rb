class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :title
      t.text :content
      t.integer :rating
      t.integer :user_id
      t.integer :reviewable_id
      t.string :reviewable_type

      t.timestamps
    end
  end
end

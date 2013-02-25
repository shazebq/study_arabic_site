class CreateImagesTableAgain < ActiveRecord::Migration
  create_table :images do |t|
    t.string :imageable_type
    t.integer :imageable_id

    t.timestamps
  end
end

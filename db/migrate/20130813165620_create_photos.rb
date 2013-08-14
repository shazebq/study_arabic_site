class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photographable_id
      t.string :photographable_type
      t.string :photo_file

      t.timestamps
    end
  end
end

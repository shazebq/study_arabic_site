class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :address_line
      t.integer :city_id
      t.integer :country_id

      t.timestamps
    end
  end
end

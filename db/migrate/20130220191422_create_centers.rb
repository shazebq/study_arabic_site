class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.text :name
      t.text :description
      t.boolean :short_term
      t.boolean :long_term
      t.string :website
      t.string :email
      t.string :phone_number
      t.integer :address_id
      t.text :program_length
      t.integer :user_id
      t.boolean :private_instruction
      t.boolean :group_instruction
      t.integer :year_established
      t.decimal :price_per_hour_private
      t.decimal :price_per_hour_group
      t.decimal :total_price
      t.boolean :housing_provided

      t.timestamps
    end
  end
end

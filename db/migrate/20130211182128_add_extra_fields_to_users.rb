class AddExtraFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :country_id, :integer
    add_column :users, :skype_id, :string
    add_column :users, :reputation, :integer
    add_column :users, :bio, :text
  end
end

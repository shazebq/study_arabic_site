class AddCountryIsoToCities < ActiveRecord::Migration
  def change
    add_column :cities, :country_iso, :string
  end
end

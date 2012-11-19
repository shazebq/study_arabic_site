class AddIpAddressToViews < ActiveRecord::Migration
  def change
    add_column :views, :ip_address, :string
  end
end

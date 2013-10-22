class AddIndexForProviderAndUid < ActiveRecord::Migration
  def up
    add_index :users, [:uid, :provider]
  end

  def down
    remove_index :users, [:uid, :provider]
  end
end

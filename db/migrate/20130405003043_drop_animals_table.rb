class DropAnimalsTable < ActiveRecord::Migration
 def up
    drop_table :animals
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end 
end

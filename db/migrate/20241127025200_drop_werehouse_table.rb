class DropWerehouseTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :werehouses
  end
end


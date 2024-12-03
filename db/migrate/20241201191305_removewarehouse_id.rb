class RemovewarehouseId < ActiveRecord::Migration[7.2]
  def change
    remove_column :shelves, :warehouseId
  end
end

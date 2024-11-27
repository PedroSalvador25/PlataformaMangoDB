class RenameWerehouseIdToWarehouseIdInShelves < ActiveRecord::Migration[7.0]
  def change
    rename_column :shelves, :werehouseId, :warehouseId
  end
end


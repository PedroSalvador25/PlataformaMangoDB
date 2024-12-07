class AddWarehouseTypeToWarehouse < ActiveRecord::Migration[7.2]
  def change
    add_column :warehouses, :warehouse_type, :string
  end
end

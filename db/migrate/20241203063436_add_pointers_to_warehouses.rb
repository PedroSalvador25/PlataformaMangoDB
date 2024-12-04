class AddPointersToWarehouses < ActiveRecord::Migration[7.2]
  def change
    add_column :warehouses, :input_pointer, :integer
    add_column :warehouses, :output_pointer, :integer
  end
end

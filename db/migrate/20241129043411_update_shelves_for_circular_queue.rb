class UpdateShelvesForCircularQueue < ActiveRecord::Migration[7.2]
  def change

   add_index :shelves, [:warehouse_id, :division, :partition], unique: true, name: 'unique_shelf_positions'

  end
end

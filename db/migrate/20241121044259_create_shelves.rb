class CreateShelves < ActiveRecord::Migration[7.2]
  def change
    create_table :shelves do |t|
      t.integer :division
      t.integer :partition
      t.integer :warehouseId
      t.integer :box_id

      t.timestamps
    end
  end
end

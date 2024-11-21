class CreateShelves < ActiveRecord::Migration[7.2]
  def change
    create_table :shelves do |t|
      t.integer :division
      t.integer :partition
      t.integer :werehouseId
      t.integer :boxId

      t.timestamps
    end
  end
end

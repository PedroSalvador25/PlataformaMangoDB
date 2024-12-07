class AddShelfPartitionToBoxes < ActiveRecord::Migration[7.2]
  def change
    add_reference :boxes, :shelf_partition, null: false, foreign_key: true
  end
end

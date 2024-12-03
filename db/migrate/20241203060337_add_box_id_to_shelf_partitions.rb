class AddBoxIdToShelfPartitions < ActiveRecord::Migration[7.2]
  def change
    add_column :shelf_partitions, :box_id, :integer
  end
end

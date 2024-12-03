class MakeShelfPartitionNullableInBoxes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :boxes, :shelf_partition_id, true
  end
end

class RemoveShelfIdFromBoxes < ActiveRecord::Migration[7.2]
  def change
    remove_column :boxes, :shelf_id, :bigint
  end
end

class UpdateDatabaseSchema < ActiveRecord::Migration[7.2]
  def change
    remove_reference :boxes, :hectare, foreign_key: true
    add_reference :shelves, :box, foreign_key: true
    add_reference :shelves, :warehouse, foreign_key: true
    remove_column :shelves, :boxId, :integer
  end
end

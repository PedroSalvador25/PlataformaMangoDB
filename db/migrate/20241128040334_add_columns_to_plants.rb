class AddColumnsToPlants < ActiveRecord::Migration[7.2]
  def change
    add_column :plants, :row, :integer, null: false
    add_column :plants, :column, :integer, null: false
  end
end

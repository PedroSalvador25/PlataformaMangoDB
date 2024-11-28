class RemoveHectareColumnFromBoxes < ActiveRecord::Migration[7.2]
  def change
    remove_column :boxes, :hectare, :integer
  end
end

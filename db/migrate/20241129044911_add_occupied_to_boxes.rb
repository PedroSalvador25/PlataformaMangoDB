class AddOccupiedToBoxes < ActiveRecord::Migration[7.2]
  def change
    add_column :boxes, :occupied, :boolean, default: false
  end
end

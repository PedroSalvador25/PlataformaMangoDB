class AddPlantToBoxes < ActiveRecord::Migration[7.2]
  def change
    add_reference :boxes, :plant, null: false, foreign_key: true
  end
end

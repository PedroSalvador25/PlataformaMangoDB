class AddHectareToBoxes < ActiveRecord::Migration[7.2]
  def change
    add_reference :boxes, :hectare, null: false, foreign_key: true
  end
end

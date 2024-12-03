class AddShelfToBoxes < ActiveRecord::Migration[7.2]
  def change
    add_reference :boxes, :shelf, null: true, foreign_key: true
  end
end

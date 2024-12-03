class Modify < ActiveRecord::Migration[7.2]
  def change
    remove_column :shelves, :box_id, :integer
  end
end

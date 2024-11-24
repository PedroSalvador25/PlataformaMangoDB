class DelatenameToBoxes < ActiveRecord::Migration[7.2]
  def change
    remove_column :boxes, :name    
  end
end

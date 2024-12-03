class ModifyShelves < ActiveRecord::Migration[7.2]
  def change
    remove_column :shelves, :division
    remove_column :shelves, :partition
  end
end

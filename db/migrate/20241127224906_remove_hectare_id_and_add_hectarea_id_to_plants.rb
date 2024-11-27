class RemoveHectareIdAndAddHectareaIdToPlants < ActiveRecord::Migration[7.2]
  def change
    remove_column :plants, :HectareId, :integer
    add_reference :plants, :hectare, null: false, foreign_key: true
  end
end

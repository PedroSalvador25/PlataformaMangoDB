class CreatePlants < ActiveRecord::Migration[7.2]
  def change
    create_table :plants do |t|
      t.integer :HectareId
      t.decimal :humidity
      t.decimal :growthMm
      t.decimal :heatJoules
      t.decimal :steamThicknessMm
      t.boolean :pestPresence
      t.string :texture
      t.decimal :oxygenationLevel

      t.timestamps
    end
  end
end

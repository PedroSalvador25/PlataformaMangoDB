class CreateWerehouses < ActiveRecord::Migration[7.2]
  def change
    create_table :werehouses do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end

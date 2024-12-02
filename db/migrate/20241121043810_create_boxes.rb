class CreateBoxes < ActiveRecord::Migration[7.2]
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :quality
      t.decimal :weigth
      t.integer :hectare

      t.timestamps
    end
  end
end

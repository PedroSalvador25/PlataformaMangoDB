class CreateShelfPartitions < ActiveRecord::Migration[7.2]
  def change
    create_table :shelf_partitions do |t|
      t.references :shelf, null: false, foreign_key: true
      t.integer :division
      t.integer :partition

      t.timestamps
    end
  end
end

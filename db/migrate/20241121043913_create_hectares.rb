class CreateHectares < ActiveRecord::Migration[7.2]
  def change
    create_table :hectares do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :community

      t.timestamps
    end
  end
end

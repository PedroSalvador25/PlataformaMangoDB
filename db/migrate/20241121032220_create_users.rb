class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :passwordDigest
      t.string :role

      t.timestamps
    end
  end
end

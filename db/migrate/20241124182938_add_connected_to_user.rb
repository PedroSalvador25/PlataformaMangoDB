class AddConnectedToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :connected, :boolean
  end
end

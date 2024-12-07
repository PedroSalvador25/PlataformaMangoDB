class AddDefaultsToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :connected, false
  end
end

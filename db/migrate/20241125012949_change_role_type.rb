class ChangeRoleType < ActiveRecord::Migration[7.2]
  def up
    change_column :users, :role, :integer, using: 'CAST(role AS integer)', default: 0
  end

  def down
    change_column :users, :role, :string
  end
end
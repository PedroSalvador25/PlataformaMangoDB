class AddAuthorizedToHectares < ActiveRecord::Migration[7.2]
  def change
    add_column :hectares, :authorized, :boolean
  end
end

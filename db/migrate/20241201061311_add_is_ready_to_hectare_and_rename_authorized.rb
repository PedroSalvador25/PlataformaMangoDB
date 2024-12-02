class AddIsReadyToHectareAndRenameAuthorized < ActiveRecord::Migration[7.2]
  def change
    add_column :hectares, :isReady, :boolean
    rename_column :hectares, :authorized, :isAuthorized
  end
  def down
    remove_column :hectares, :is_ready
  end
end

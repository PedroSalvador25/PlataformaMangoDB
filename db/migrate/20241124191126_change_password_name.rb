class ChangePasswordName < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :passwordDigest, :password_digest
  end
end

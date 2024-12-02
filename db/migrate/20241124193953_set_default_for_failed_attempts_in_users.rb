class SetDefaultForFailedAttemptsInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :failed_attempts, from: nil, to: 0
    change_column_null :users, :failed_attempts, false
  end
end

class AddingLoginStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_session, :integer, null: false, default: 0
  end
end

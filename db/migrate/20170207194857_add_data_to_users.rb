class AddDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    add_attachment :users, :photo, :attachment
  end
end

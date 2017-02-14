class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :type_room, null: false, default: 0

      t.timestamps
    end
  end
end

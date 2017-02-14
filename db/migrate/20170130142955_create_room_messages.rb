class CreateRoomMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :room_messages do |t|
      t.text :body
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

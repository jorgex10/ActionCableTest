class AddReadFlagToRoomMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :room_messages, :read, :boolean, null: false, default: false
    add_column :room_messages, :read_at, :datetime
  end
end

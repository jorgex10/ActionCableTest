class Room < ApplicationRecord

  has_many :room_messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms

  enum type_room: [:user_type, :group_type]

  def set_name user
    if self.user_type?
      (self.users - [user]).first.full_name
    else
      ''
    end
  end

  def receiver sender
    receiver = nil
    if self.user_type?
      receiver = self.users - [sender]
    end
    receiver.first
  end

  def self.find_or_initialize_by_users sender, receiver
    sql = "SELECT rooms.* FROM rooms INNER JOIN user_rooms ON rooms.id = user_rooms.room_id WHERE user_rooms.user_id = #{sender.id} INTERSECT SELECT rooms.* FROM rooms INNER JOIN user_rooms ON rooms.id = user_rooms.room_id WHERE user_rooms.user_id = #{receiver.id}"
    rooms = ActiveRecord::Base.connection.execute(sql)
    room = rooms.first
    if room.nil?
      room = Room.create
      sender.user_rooms.create room: room
      receiver.user_rooms.create room: room
    end
    return room
  end

end

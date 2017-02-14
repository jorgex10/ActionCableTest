class NotificationsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "notifications_channel_#{current_user.id}"
  end

  def unsubscribed
  end

  def send_message data
    current_room = Room.find_by id: data['room_id']
    RoomMessage.create body: data['message'], user_id: current_user.id, room_id: current_room.id
  end

end

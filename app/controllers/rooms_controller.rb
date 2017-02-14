class RoomsController < ApplicationController

  before_action :pagination, only: :show

  def show
    room = Room.find params[:id]
    @messages = room.room_messages if room
  end

  def create
    sender = User.find_by id: params[:sender_id]
    receiver = User.find_by id: params[:receiver_id]
    room = Room.find_or_initialize_by_users sender, receiver
    render js: ''
  end

  def make_messages_as_read
    room = Room.find_by id: params[:id]
    receiver = User.find_by id: params[:receiver_id]
    sender = (room.users - [receiver]).first
    if room
      unread_messages = RoomMessage.where room: room, user: sender, read: false
      unread_messages.update_all read: true
    end
  end

  private

  def pagination
    @limit = params[:limit] || 70
    @offset = params[:offset] || 0
  end

end

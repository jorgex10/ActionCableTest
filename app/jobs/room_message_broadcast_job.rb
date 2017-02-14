class RoomMessageBroadcastJob < ApplicationJob

  queue_as :default

  def perform message
    receivers = message.room.users.map(&:id)
    message.room.users.each do |receiver|
      ActionCable.server.broadcast "notifications_channel_#{receiver.id}", message: render_message(message), receivers: receivers, sender_id: message.user.id, room_id: message.room.id
    end
  end

  private

  def render_message message
    ApplicationController.renderer.render(partial: 'layouts/chat_views/room_message', locals: { message: message })
  end

end

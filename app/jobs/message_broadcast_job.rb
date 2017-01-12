class MessageBroadcastJob < ApplicationJob

  queue_as :default

  def perform user_message
    ActionCable.server.broadcast "message_channel_user_#{user_message.user.id}", message: render_message(user_message), unread_number_messages: user_message.user.unread_messages.count, message_id: user_message.message.id
  end

  private

  def render_message user_message
    MessagesController.render partial: 'messages/message', locals: { message: user_message.message, current_user: user_message.user }
  end

end

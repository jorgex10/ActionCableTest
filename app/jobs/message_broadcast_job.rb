class MessageBroadcastJob < ApplicationJob

  queue_as :default

  def perform user_message
    ActionCable.server.broadcast "message_channel_user_#{user_message.user.id}", message: render_message(user_message.message)
  end

  private

  def render_message message
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
  end

end

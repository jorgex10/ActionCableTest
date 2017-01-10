# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel

  def subscribed
    stream_from "message_channel_user_#{current_user.id}"
  end

  def unsubscribed
  end

  def set_new_messages data
    message = Message.create sender: current_user, body: data['message']
    receivers = data['receivers'].split(',')
    receivers.each do |r|
      receiver = User.find r
      UserMessage.create user: receiver, message: message
    end
  end

end

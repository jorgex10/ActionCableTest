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

  def set_new_starred data
    message = Message.find data['message_id']
    new_starred_message = current_user.favorite_messages.find_or_initialize_by message: message
    new_starred_message.new_record? ? new_starred_message.save : new_starred_message.destroy
    ActionCable.server.broadcast "message_channel_user_#{current_user.id}", starred_message_number: current_user.starred_messages.count
  end

end

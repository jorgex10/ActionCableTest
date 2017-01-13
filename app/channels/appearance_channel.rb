class AppearanceChannel < ApplicationCable::Channel

  def subscribed
    stream_from "users_status_channel"
    current_user.online!
    ActionCable.server.broadcast "users_status_channel", user_id: current_user.id, sign_in: true
  end

  def unsubscribed
    current_user.offline!
    ActionCable.server.broadcast "users_status_channel", user_id: current_user.id, sign_in: false
  end

end

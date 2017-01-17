class MessagesController < ApplicationController

  before_action :set_message, only: :show

  def index
  end

  def new
    @message = Message.new
  end

  def show
    if @message.can_show? current_user
      @message.read! current_user if @message.is_receiver? current_user
    else
      redirect_to messages_path, alert: "You are not sender or receiver for this message"
    end
  end

  def sent
    @messages = current_user.sent_messages.includes(:sender)
  end

  def unread
    @messages = current_user.unread_messages.includes(:sender)
  end

  def read
    @messages = current_user.read_messages.includes(:sender)
  end

  def starred
    @messages = current_user.starred_messages.includes(:sender)
  end

  private

  def set_message
    @message = Message.find params[:id]
  end

  def message_params
    params.require(:message).permit(:body)
  end

end

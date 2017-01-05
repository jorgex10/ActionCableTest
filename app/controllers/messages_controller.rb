class MessagesController < ApplicationController

  before_action :set_message, only: :show

  def index
  end

  def new
    @message = Message.new
  end

  def create
    message = Message.new message_params
    message.sender = current_user
    if message.valid?
      message.save
      receivers = params[:receivers].split(',')
      ap receivers
      receivers.each do |receiver|
        UserMessage.create(user_id: receiver, message: message)
      end
      redirect_to sent_messages_path, notice: "Your message has been sent successfully!"
    else
      render :new
    end
  end

  def show
    if @message.can_show? current_user
      @message.read! current_user if @message.is_receiver? current_user
    else
      redirect_to messages_path, alert: "You are not sender or receiver for this message"
    end
  end

  def sent
    @messages = current_user.sent_messages
  end

  def unread
    @messages = current_user.unread_messages
  end

  def read
    @messages = current_user.read_messages
  end

  private

  def set_message
    @message = Message.find params[:id]
  end

  def message_params
    params.require(:message).permit(:body)
  end

end

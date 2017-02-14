if @messages
  json.messages @messages.includes(:user).limit(@limit).offset(@offset).order(:created_at) do |message|
    json.user_email message.user.email
    json.user_photo user_avatar(message.user.id)
    json.body message.body
    json.created_at date_formatter_for_chat(message.created_at)
  end
end

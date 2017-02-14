App.notifications = App.cable.subscriptions.create "NotificationsChannel",

  received: (data) ->
    data['receivers'].forEach (element, index) ->
      if data['sender_id'] != element
        $('#room-label-chat-' + data['room_id'] + element).addClass("unread-message-indicator")
      $('#chat-history-' + data['room_id'] + element).append data['message']
      messages = $('#chat-history-' + data['room_id'] + element)
      messages_to_bottom = ->
        messages.scrollTop messages.prop('scrollHeight')
      messages_to_bottom()

  send_message: (room_id, message) ->
    @perform 'send_message', room_id: room_id, message: message

jQuery(document).on 'turbolinks:load', ->
  $('.chat-initializer').click (e) ->
    current_user_id = $('#current-user-id').data('user-id')
    room_id = $(this).data('room-id')
    $(document).on 'keypress', '#send_message_' + room_id + current_user_id, (e) ->
      if event.keyCode is 13
        App.notifications.send_message room_id, $(this).val()
        $(this).val('')
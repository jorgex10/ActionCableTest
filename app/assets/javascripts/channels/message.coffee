App.message = App.cable.subscriptions.create "MessageChannel",

  received: (data) ->
    $('#alert-no-message').hide()
    $('#unread-messages-number').html data['unread_number_messages']
    $('#starred-messages-number').html data['starred_message_number']
    if data['message_id']
      notify(data['message_id'])
    return $('#unread-messages').append data['message']

  set_new_messages : (message, receivers) ->
    @perform 'set_new_messages', message: message, receivers: receivers

  set_new_starred : (message_id) ->
    @perform 'set_new_starred', message_id: message_id

jQuery(document).on 'turbolinks:load', ->
  $('#form_message').submit (e) ->
    App.message.set_new_messages $("#form_message #message_body").val(), $("#form_message #receivers").val()
    window.location.href = '/messages/sent'
    show_sent_message_notification()
    e.preventDefault()

  $('.start-for-message').click (e) ->
    App.message.set_new_starred $(this).data("message-id")
    $(this).toggleClass("active")
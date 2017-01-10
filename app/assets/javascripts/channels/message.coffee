App.message = App.cable.subscriptions.create "MessageChannel",

  received: (data) ->
    $('#alert-no-message').hide()
    $('#unread-messages-number').html data['unread_number_messages']
    notify(data['message_id'])
    return $('#unread-messages').append data['message']

  set_new_messages : (message, receivers) ->
    @perform 'set_new_messages', message: message, receivers: receivers

jQuery(document).on 'turbolinks:load', ->
  $('#form_message').submit (e) ->
    App.message.set_new_messages $("#form_message #message_body").val(), $("#form_message #receivers").val()
    window.location.href = '/messages/sent'
    show_sent_message_notification()
    e.preventDefault()
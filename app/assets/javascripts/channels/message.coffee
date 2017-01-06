jQuery(document).on 'turbolinks:load', ->

  App.message = App.cable.subscriptions.create {
      channel: "MessageChannel"
      user_id: $("#user-label").data("sender-id")
    },

    connected: ->

    disconnected: ->

    received: (data) ->
      $('#alert-no-message').hide()
      $('#unread-messages').removeClass('hidden')
      $('#unread-messages').append data['message']

    update_unread_number: (message, receivers) ->
      @perform 'update_unread_number', message: message, receivers: receivers

  $(document).on 'click', '[data-behavior~=message_sender]', (event) ->
    App.message.update_unread_number $("#form_message #message_body").val(), $("#form_message #receivers").val()
    event.preventDefault()
    window.location = "sent"
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require cable
//= require notification
//= require_tree .

widget_trigger = function(user_id, user_mail, user_status_on_session){
  var can_create = true;
  $( ".live-chat" ).each(function(index) {
    if ($(this).attr('id') == ('live-chat-' + user_id)) {
      can_create = false;
    }
  });
  if (can_create) {
    var actives = $(".live-chat");
    var new_right_value = (actives.length - 1) * 310 + 24;
    if (actives.length <= 3) {
      $('.live-chat:last').clone().appendTo('#conversations');
      $('.live-chat:last').attr('id', 'live-chat-' + user_id);
      $(".live-chat:last .chat-close").attr('id', 'chat-close-' + user_id);
      $(".live-chat:last .chat").attr('id', 'chat-' + user_id);
      $(".live-chat:last .chat-message-counter").attr('id', 'chat-message-counter-' + user_id);
      $(".live-chat:last .user-status").attr('id', 'user-status-' + user_id);
      $(".live-chat:last header").attr('id', 'header-' + user_id);
      $('.live-chat:last').css('right', new_right_value);
      $('.live-chat:last').show();
      $('.live-chat:last #user-email').html(user_mail);
      if (user_status_on_session == 'online') {
        $('#user-status-' + user_id).removeClass("offline");
      }
      else{
        $('#user-status-' + user_id).addClass("offline");
      }
      (function() {
        $("#live-chat-" + user_id + " #header-" + user_id).on('click', function() {
          $('#chat-' + user_id).slideToggle(300, 'swing');
          $('#chat-message-counter-' + user_id).fadeToggle(300, 'swing');
        });
        $('#chat-close-' + user_id).on('click', function(e) {
          $('#live-chat-' + user_id).fadeOut(300);
          $('#live-chat-' + user_id).remove();
          refactor_positions();
          e.preventDefault();
        });
      }) ();
    }
  }
}

refactor_positions = function(){
  var widget_actives = $(".live-chat").length - 1;
  var new_right_value = 24;
  $( ".live-chat" ).each(function(index) {
    if (index != 0) {
      $(this).animate({"right": new_right_value});
      new_right_value = new_right_value + 310;
    }
  });
}
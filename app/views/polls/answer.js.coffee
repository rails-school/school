$(".polls").fadeOut 500, ->
  $(".polls[data-id='<%= @poll.id %>']").replaceWith("<%= escape_javascript(render :partial => "polls/poll", :locals => {:last_completed_poll => @poll}) %>")
$(".polls").show()

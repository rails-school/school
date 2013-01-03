$(".polls").fadeOut 500, ->
  $(".polls[data-id='<%= @poll.id %>']").replaceWith("<%= escape_javascript(render :partial => "polls/poll", :locals => {:previous_poll => @poll}) %>")
$(".polls").show()

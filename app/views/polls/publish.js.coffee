poll_id = <%= @poll.id %>
$(".poll[data-id='#{poll_id}'] .publish").html("<%= escape_javascript(render :partial => "polls/publish_link", :locals => {:poll => @poll}) %>")

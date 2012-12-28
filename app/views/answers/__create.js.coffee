$(".polls").fadeOut 500, ->
  $(".polls[data-id='<%= @answer.question.id %>']").replaceWith("<%= escape_javascript(render :partial => "questions/poll") %>")
$(".polls").show()

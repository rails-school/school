$(document).on "click", ".rsvp a[data-must-login='true']", (e) ->
  lesson_id = $(@).closest(".rsvp").data("id")
  $("#LoginModal input[name='rsvp_for']").val(lesson_id) 
  $("#LoginModal").reveal()
  false

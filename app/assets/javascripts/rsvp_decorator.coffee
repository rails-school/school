$ ->
  if typeof(gon) != "undefined" && gon.signed_in
    $("a.a_button").data("method", "POST")
    $("a.a_button").attr("data-reveal-id", null)
    for lesson in gon.user_lessons
      button = $("div.rsvp[data-id='#{lesson}']").find("a.a_button")
      href = button.attr("href")
      button.attr("href", href+"/delete")
      button.addClass("pressed")
      button.html("unRSVP")

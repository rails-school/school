$(document).ready ->
  $(document).on "click", ".show_map", (e) ->
    e.preventDefault()
    $(".the_map").stop().animate({opacity:1, height:"450px"})

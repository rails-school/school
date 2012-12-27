# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $(document).on "click", ".show_map", (e) ->
    e.preventDefault()
    $(".the_map").stop().animate({opacity:1, height:"450px"})

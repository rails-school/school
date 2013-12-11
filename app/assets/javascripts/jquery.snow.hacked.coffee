###
jquery.snow - jQuery Snow Effect Plugin

Available under MIT licence

@version 1 (21. Jan 2012)
@author Ivan Lazarevic
@requires jQuery
@see http://workshop.rs

@params minSize - min size of snowflake, 10 by default
@params maxSize - max size of snowflake, 20 by default
@params newOn - frequency in ms of appearing of new snowflake, 500 by default
@params flakeColor - color of snowflake, #FFFFFF by default
@example $.fn.snow({ maxSize: 200, newOn: 1000 });
###
$ ->
  $flake = $("<div id=\"flake\" />").css(
    position: "absolute"
    top: "-50px"
  ).html("&#10052;")
  documentHeight = $(document).height()
  documentWidth = $(document).width()

  flake = (x, y) ->
    options =
      minSize: 5
      maxSize: 75
      flakeColor: "#FFFFFF"

    startPositionLeft = x - 100 + (Math.random() * 200)
    startPositionTop = y - 100 + (Math.random() * 200)
    startOpacity = 0.5 + Math.random()
    sizeFlake = options.minSize + Math.random() * options.maxSize
    endPositionTop = documentHeight - 40
    endPositionLeft = startPositionLeft - 100 + Math.random() * 200
    durationFall = documentHeight * 10 + Math.random() * 5000
    $flake.clone().appendTo("body").css(
      top: startPositionTop
      left: startPositionLeft
      opacity: startOpacity
      "font-size": sizeFlake
      color: options.flakeColor
    ).animate
      top: endPositionTop
      left: endPositionLeft
      opacity: 0.2
    , durationFall, "linear", ->
      $(this).remove()

  old_page_x = null
  old_page_y = null
  $(document).mousemove (event) ->
    if old_page_x
      delta_x = Math.abs(old_page_x - event.pageX)
      delta_y = Math.abs(old_page_y - event.pageY)
      delta = Math.sqrt(delta_x*delta_x + delta_y+delta_y)
      if delta > 50
        flake(event.pageX, event.pageY) for [1..parseInt(delta/10)]
    old_page_x = event.pageX
    old_page_y = event.pageY

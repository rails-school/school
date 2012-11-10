$(document).ready ->
  $(document).on "click", ".expand_lesson", (e) ->
    e.preventDefault()
    if $(this).hasClass("opened")
      $(".lessons_list li").removeClass("white")
      $(".lessons_list .details").hide(500)
      $(".expand_lesson").removeClass("opened")
    else
      $(".lessons_list .details:not(.details[data-lesson='#{id}'])").hide(500)
      $(".lessons_list li").removeClass("white")
      $(".expand_lesson").removeClass("opened")
      $(this).addClass("opened")
      id = $(this).data("lesson")
      $(".lessons_list .details[data-lesson='#{id}']").toggle(500)
      $(".lessons_list .details[data-lesson='#{id}']").parent().addClass("white")

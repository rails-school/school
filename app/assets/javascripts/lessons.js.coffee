$(document).ready ->
  $(document).on "click", ".expand_lesson", (e) ->
    e.preventDefault()
    $(".lessons_list .details:not(.details[data-lesson='#{id}'])").hide(500)
    $(".lessons_list li").removeClass("white")
    id = $(this).data("lesson")
    $(".lessons_list .details[data-lesson='#{id}']").toggle(500)
    $(".lessons_list .details[data-lesson='#{id}']").parent().addClass("white")

$(document).ready ->
  $(document).on "click", ".expand_lesson", (e) ->
    e.preventDefault()
    $(".lessons_list .details:not(.details[data-lesson='#{id}'])").hide(500)
    id = $(this).data("lesson")
    $(".lessons_list .details[data-lesson='#{id}']").toggle(500);
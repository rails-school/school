$(document).on "blur", ".content form.new_user input#user_email", ->
  $(this).mailcheck
    suggested: (element, suggestion) ->
      $('form.new_user #suggestion .address').html(suggestion.address)
      $('form.new_user #suggestion .domain').html(suggestion.domain)
      $('form.new_user #suggestion a').attr("data-email", suggestion.full)
      $('form.new_user #suggestion').show()
    empty: (element) ->
      $('form.new_user #suggestion').hide()

$(document).on "click", "a[data-action='choose-suggested-email']", ->
  $(".content form.new_user input#user_email").val($(this).attr('data-email'))
  $(".content form.new_user input#user_email").trigger("blur")
  $(".content form.new_user input#user_name").focus()
  false

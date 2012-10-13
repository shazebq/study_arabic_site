$(document).ready ->
  $(".vote_up").bind("click", ->
    alert($(this).data("post_id"))

  )

  # call rails action
  # on callback reload
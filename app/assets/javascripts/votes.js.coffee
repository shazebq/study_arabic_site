$(document).ready ->
  $(".vote").bind("click", ->
    $.ajax
      url: "/forum_posts/vote"
      type: "POST"
      data:
        forum_post_id: $(this).attr("data-post_id")
        type: $(this).attr("data-type")
      dataType: "json"
      success: (data) ->
        # change color or arrow
        # change vote count on show page
        alert("vote count is now: " + data)
  )
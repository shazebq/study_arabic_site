$(document).ready ->
  $(".vote").bind("click", ->
    $.ajax
      url: "/forum_posts/vote"
      type: "POST"
      data:
        forum_post_id: $(this).attr("data-post_id")
        type: $(this).attr("data-type")
      dataType: "json"
      success: (data) =>
        #change color of arrow
        $(".vote").removeClass("selected_vote")
        $(this).addClass("selected_vote")
        $(".vote_count").html("+" + data)
        # change vote count on show page
  )

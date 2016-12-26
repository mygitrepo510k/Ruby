$("#left_side_nav > li > a").click ->
  unless $(this).attr("class") is "active"
    $("#left_side_nav li ul").slideUp()
    $(this).next().slideToggle()
    $("#left_side_nav li a").removeClass "active"
    $(this).addClass "active"
  return


$("#left_side_nav > li.content-list a").click ->
  url_ajax = $(this).data("link")
  $("#main_contents_list").children().remove()
  $.get(url_ajax)
  .always((data) ->
    $("#main_contents_list").append(data["responseText"])
    return
  )
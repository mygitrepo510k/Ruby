class window.Connect
  constructor: ->
    @setup()

  setup: ->
    @connectContent = $(".networks.connect")
    @selectedCount = @connectContent.find(".selected-count")
    @connectForm = @connectContent.find(".connect-form")
    @maxConnect = @connectContent.find("input[type='checkbox']").length
    @connectButton = @connectContent.find("input.btn-connect")
    @clickOnParentNode()
    @clickOnChildNode()
    @addConnects()
    @connectContent.find("input[type='checkbox']").prop("checked",false)

  clickOnParentNode: ->
    @connectContent.find("input[data-type=parent]").click((e)=>
      if e.target.checked
        @connectContent.find("input[data-type=child]").prop("checked", true)
        @connectButton.addClass("clickable")
        @connectButton.removeClass("unclickable")
      else
        @connectContent.find("input[data-type=child]:checked").prop("checked", false)
        @connectButton.removeClass("clickable")
        @connectButton.addClass("unclickable")

      @addSelectedCount(@connectContent.find("input[data-type=child]:checked").length)
    )
  clickOnChildNode: ->
    @connectContent.find("input[data-type=child]").click((e)=>
      length = @connectContent.find("input[data-type=child]:checked").length
      @addSelectedCount(length)
      if length is @maxConnect
        @connectContent.find("input[data-type=parent]").prop("checked", true)
      else
        @connectContent.find("input[data-type=parent]").prop("checked", false)

      if length == 0
        @connectButton.addClass("unclickable")
        @connectButton.removeClass("clickable")
      else
        @connectButton.addClass("clickable")
        @connectButton.removeClass("unclickable")
    )
  addConnects: ->
    @connectContent.delegate(".btn-connect.clickable", "click", (e)=>
      ids = @connectContent.find("input[data-type=child]:checked").map (index, item) -> item.id
      @connectForm.find("#ids").val(ids.toArray().join(","))
      @connectForm.submit()
    )

  addSelectedCount: (count) ->
    @selectedCount.html(count)

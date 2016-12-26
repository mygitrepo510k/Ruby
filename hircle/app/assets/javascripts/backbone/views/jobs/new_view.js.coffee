Hircle.Views.Jobs ||= {}
class Hircle.Views.Jobs.NewView extends Backbone.View
  template: JST["backbone/templates/jobs/new"]
  
  events:
    "submit #new-job": "save"    

    "click #new_post_job .job-preview": "PreviewPostJob"
    "click #new_post_job .job-next": "NextPostJob"    
    "click #post_job_next .job-back": "BackJob"
    "click #main_area .btn-new-job": "PostJob"
    
    "click #next-post-job .job-submit": "save"
    "click #new_post_job .job-submit": "save"

  PostJob: () ->
    $('#new_post_job').modal({
      backdrop: false,
      show: true
    })

  NextPostJob: ()->
    $('#new_post_job').modal('hide')
    $('#post_job_next').modal({
      backdrop: false,
      show: true
    })
    $("#is_job_state_group button").each ->
      button = $(this)
      button.click ->
        $("#is_job_state_group button").each ->
          $(this).removeClass "active"
        $("#visibility").val $(this).val()
        if button.val() is $("#visibility").val()
          button.addClass "active"
        else
          console.log "error"

  BackJob: () ->
    $('#post_job_next').modal('hide')
    $('#new_post_job').modal({
      backdrop: false,
      show: true
    })

  PreviewPostJob: () ->
    console.log("PrevPostJob")

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (job) =>
        @model = job
        window.location.hash = "/#{@model.id}"

      error: (job, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

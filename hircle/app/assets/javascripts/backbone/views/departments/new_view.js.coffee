Hircle.Views.Departments ||= {}

class Hircle.Views.Departments.NewView extends Backbone.View
  template: JST["backbone/templates/departments/new"]

  events:
    "submit #new-department": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    console.log "---it is save---"
    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (department) =>
        @model = department
        window.location.hash = "/#{@model.id}"

      error: (department, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

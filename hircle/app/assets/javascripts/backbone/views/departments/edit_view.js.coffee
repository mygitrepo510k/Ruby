Hircle.Views.Departments ||= {}

class Hircle.Views.Departments.EditView extends Backbone.View
  template : JST["backbone/templates/departments/edit"]

  events :
    "submit #edit-department" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (department) =>
        @model = department
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

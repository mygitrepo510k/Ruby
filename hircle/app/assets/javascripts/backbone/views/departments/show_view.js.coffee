Hircle.Views.Departments ||= {}

class Hircle.Views.Departments.ShowView extends Backbone.View
  template: JST["backbone/templates/departments/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

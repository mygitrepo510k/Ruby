Hircle.Views.Employees ||= {}

class Hircle.Views.Employees.EmployeeView extends Backbone.View
  template: JST["backbone/templates/employees/employee"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

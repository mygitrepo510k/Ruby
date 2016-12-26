Hircle.Views.Departments ||= {}

class Hircle.Views.Departments.DepartmentView extends Backbone.View
  template: JST["backbone/templates/departments/department"]

  events:
    "click #destroy" : "destroy"

  #tagName: "tr"
  #tagName: "li"
  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

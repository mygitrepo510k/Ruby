Hircle.Views.Activities ||= {}

class Hircle.Views.Activities.ActivityView extends Backbone.View
  template: JST["backbone/templates/activities/activity"]
  
  events:
    "click .destroy" : "destroy"

  #tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

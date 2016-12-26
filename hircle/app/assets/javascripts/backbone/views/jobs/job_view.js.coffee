Hircle.Views.Jobs ||= {}
class Hircle.Views.Jobs.JobView extends Backbone.View
  template: JST["backbone/templates/jobs/job"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this

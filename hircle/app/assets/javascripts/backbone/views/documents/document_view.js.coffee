Hircle.Views.Documents ||= {}

class Hircle.Views.Documents.DocumentView extends Backbone.View
  template: JST["backbone/templates/documents/document"]

  events:
    "click .destroy" : "destroy"


  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

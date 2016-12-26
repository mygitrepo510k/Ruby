Hircle.Views.Tasks ||= {}

class Hircle.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

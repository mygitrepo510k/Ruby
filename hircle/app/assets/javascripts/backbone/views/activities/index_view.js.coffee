Hircle.Views.Activities ||= {}

class Hircle.Views.Activities.IndexView extends Backbone.View
  template: JST["backbone/templates/activities/index"]

  initialize: () ->
    @options.activities.bind('reset', @addAll)

  addAll: () =>
    console.log "add all:"+@options.activities.length
    @options.activities.each(@addOne)

  addOne: (activity) =>
    view = new Hircle.Views.Activities.ActivityView({model : activity})
    @$("#department_activities_list").append(view.render().el)

  render: =>
    $(@el).html(@template(activities: @options.activities.toJSON() ))
    @addAll()

    return this

class Hircle.Routers.ActivitiesRouter extends Backbone.Router
  initialize: (options) ->
    @activities = new Hircle.Collections.ActivitiesCollection()
    @activities.reset options.activities
  #this router is still not used
  routes:
    "new"      : "newActivity"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newActivity: ->
    @view = new Hircle.Views.Activities.NewView(collection: @activities)
    $("#activities").html(@view.render().el)

  index: ->
    @view = new Hircle.Views.Activities.IndexView(activities: @activities)
    $("#activities").html(@view.render().el)

  show: (id) ->
    activity = @activities.get(id)

    @view = new Hircle.Views.Activities.ShowView(model: activity)
    $("#activities").html(@view.render().el)

  edit: (id) ->
    activity = @activities.get(id)

    @view = new Hircle.Views.Activities.EditView(model: activity)
    $("#activities").html(@view.render().el)

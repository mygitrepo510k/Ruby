class Hircle.Routers.TasksRouter extends Backbone.Router
  initialize: (options) ->
  
  routes:
    "index"    : "index"
    ".*"        : "index"
  
  index: ->
    @view = new Hircle.Views.Tasks.IndexView()
    $("#tasks").html(@view.render().el)


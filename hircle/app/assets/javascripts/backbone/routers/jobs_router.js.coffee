class Hircle.Routers.JobsRouter extends Backbone.Router
  initialize: (options) ->
    @jobs = new Hircle.Collections.JobsCollection()
    @jobs.reset options.jobs

  routes:
    "new"      : "newJob"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"
  
  newJob: ->
    @view = new Hircle.Views.Jobs.NewView(collection: @jobs)
    $("#jobs").html(@view.render().el)

  index: ->
    @view = new Hircle.Views.Jobs.IndexView(jobs: @jobs)
    $("#jobs").html(@view.render().el)

  show: (id) ->
    job = @jobs.get(id)

    @view = new Hircle.Views.Jobs.ShowView(model: job)
    $("#jobs").html(@view.render().el)

  edit: (id) ->
    job = @jobs.get(id)

    @view = new Hircle.Views.Jobs.EditView(model: job)
    $("#jobs").html(@view.render().el)

Hircle.Views.Jobs ||= {}
class Hircle.Views.Jobs.IndexView extends Backbone.View
  template: JST["backbone/templates/jobs/index"]

  events:
    "click #left_side .applicants": "ApplicantManage"
    "click #left_side .interviews": "Interviews"
  
  ApplicantManage: () ->
    console.log("ApplicantManage")
  Interviews: () ->
    console.log("Interviews")

  initialize: () ->
    @options.jobs.bind('reset', @addAll)

  addAll: () =>
    @options.jobs.each(@addOne)

  addOne: (job) =>
    view = new Hircle.Views.Jobs.JobView({model : job})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(jobs: @options.jobs.toJSON() ))
    @addAll()

    return this


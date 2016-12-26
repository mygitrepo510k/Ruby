Hircle.Views.Tasks ||= {}

class Hircle.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  initialize: () ->
    @tasksCollection = new Hircle.Collections.TasksCollection()
    @tasksCollection.bind("reset",@render)
    @tasksCollection.fetch()
    @assigneesCollection = new Hircle.Collections.AssigneesCollection(gon.assignee_list)
    console.log @assigneesCollection
    
  addAll: () =>
   @tasksCollection.each(@addOne)

  addOne: (task) =>
    view = new Hircle.Views.Tasks.TaskView({model : task})
    @$("#task_list").append(view.render().el)
    assignments = task.get("assignments")
    if assignments.length > 0
      for assignee in assignments 
        as = @assigneesCollection.where(id:assignee.assignee_id)[0]
        console.log "for loop"
        console.log as.full_name()
        div = jQuery('<div/>', {
          class: "addedUserContent"
        }).html("<input type='text' width='auto' value='#{as.full_name()}' readonly>")
        @$("#edit_asignee_list#{task.id}").append(div)

  render: =>
    console.log "calling render"
    console.log @tasksCollection
    $(@el).html(@template(tasks: @tasksCollection.toJSON() ))
    @view = new Hircle.Views.Tasks.NewView(collection: @tasksCollection)
    @$("#task_form").html(@view.render().el)
    @addAll()

    return this

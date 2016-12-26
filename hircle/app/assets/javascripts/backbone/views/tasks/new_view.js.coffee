Hircle.Views.Tasks ||= {}

class Hircle.Views.Tasks.NewView extends Backbone.View
  template: JST["backbone/templates/tasks/new"]
  
  initialize:(options)->
    @tasksColleciton = options.collection
    
  events:
    "click #create_task_btn": "save"
    "click #assign_btn" : "assignTask"
  
  assignTask:()->
    assignee_map = {}
    $.each(gon.assignee_list,(i,assignee)->
      assignee_map["#{assignee.first_name} #{assignee.last_name}"] = assignee.id
    )
    console.log assignee_map[$("#addAssigneeTypeAhead").val()]
    assignee_name = $("#addAssigneeTypeAhead").val()

    jQuery('<div/>', {
      class: "addedUserContent"
    })
    .html("<input type='hidden' name='assignee[]' value='#{assignee_map[assignee_name]}' readonly><input type='text' width='auto' value='#{assignee_name}' readonly>")
    .appendTo("#asignee_list")
    
    $("#addAssigneeTypeAhead").val("")
    
  resetTasks:(collection)->
    console.log "resetting tasks"
    console.log collection
    collection.fetch()
  
  saveTask:(callback,collection)->
    $("#new-task").ajaxForm(
      success: ()->
        callback(collection)
      error:()->
        console.log "error in saving task"
    )
    $("#new-task").submit()
  
  formatDueDate: () ->
    str = $("#day").val() + "/"
    str += $("#month").val() + "/"
    str += new Date().getFullYear() + " "
    date = $("#hour").timepicker('getTime')
    str += date.getHours() + ":"+ date.getMinutes() + ":00"
    return str
    
  save: (e) ->
    e.preventDefault()
    $("input[name='task[due_date]']").val(@formatDueDate())
    @saveTask(@resetTasks,@tasksColleciton)

  setViewComponents: ()->
  
    @$("#day").datepicker().on("changeDate",(ev)->
      date = new Date(ev.date);
      $("#day").val(date.getDate())
      $("#day").datepicker("hide")
    )
    
    @$("#month").datepicker(
       format: " mm",
       viewMode: "months",
       minViewMode: "months"
    ).on("changeDate",(ev)->
      date = new Date(ev.date)
      $("#month").datepicker("hide")
      $("#month").val(date.getMonth() + 1)
    )
    @$("#hour").timepicker()
    
    typeAheadData = $.map(gon.assignee_list,(item,index)-> return item.first_name+" "+item.last_name)
    
    @$('#addAssigneeTypeAhead').typeahead(
      source: typeAheadData
      matcher:(item) ->
        return true
      updater:(item) ->
        return item
    )
    
  render: ->
    $(@el).html(@template)
    @setViewComponents()
    return this
    

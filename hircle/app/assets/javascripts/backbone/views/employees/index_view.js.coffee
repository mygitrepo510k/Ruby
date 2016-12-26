Hircle.Views.Employees ||= {}

class Hircle.Views.Employees.IndexView extends Backbone.View
  template: JST["backbone/templates/employees/index"]

  initialize: () ->    
  
  events:
    "click #users_add_button": "addUsers"
  
  addUsers: () ->
    console.log "department id is :"+$("#selected_department_id").val()
    url='/departments/'+$("#all_want_users").val()+'/addemployees/'+$("#selected_department_id").val()+".json"
    #departments/:ids/addemployees/:department_id
    $.ajax url,
       type: 'POST'       
       dataType: 'json'
       data: {}
       async: false
      success: (data)->
        console.log "add users to department success"
        console.log data  
    
      error:(e)->
        console.log "error add users to department"
        console.log e
    

  addAll: () =>
    console.log 'add employee data :'+@employees.length
    @employees.each(@addOne)

  addOne: (employee) =>
    view = new Hircle.Views.Employees.EmployeeView({model : employee})
    @$("#J_EmployeeList").append(view.render().el)

  render: =>
    $(@el).html(@template(employees: @employees.toJSON() ))
    @addAll()

    return this

class Hircle.Routers.EmployeesRouter extends Backbone.Router
  initialize: (options) ->
    @employees = new Hircle.Collections.EmployeesCollection()
    @employees.reset options.employees
  routes:
 
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  
  index: ->
    @view = new Hircle.Views.Employees.IndexView(employees: @employees)
    $("#employees").html(@view.render().el)

  show: (id) ->
    employee = @employees.get(id)

    @view = new Hircle.Views.Employees.ShowView(model: employee)
    $("#employees").html(@view.render().el)

  edit: (id) ->
    employee = @employees.get(id)

    @view = new Hircle.Views.Employees.EditView(model: employee)
    $("#employees").html(@view.render().el)

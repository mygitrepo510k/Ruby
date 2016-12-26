class Hircle.Models.Employee extends Backbone.Model
  paramRoot: 'employee'

  defaults:
    name: null
    email: null

class Hircle.Collections.EmployeesCollection extends Backbone.Collection
  model: Hircle.Models.Employee
  #url: '/companies/1/employees'

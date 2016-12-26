class Hircle.Models.Department extends Backbone.Model
  paramRoot: 'department'

  defaults:
    name: null
    description: null
    company_id: null

class Hircle.Collections.DepartmentsCollection extends Backbone.Collection
  model: Hircle.Models.Department
  url: '/departments'

  

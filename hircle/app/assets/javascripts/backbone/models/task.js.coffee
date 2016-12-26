class Hircle.Models.Task extends Backbone.Model
  paramRoot: 'task'
  url: "/tasks"
  
  defaults:
    title: null
    description: null
    status: null
    priority: null

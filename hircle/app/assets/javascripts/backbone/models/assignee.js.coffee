class Hircle.Models.Assignee extends Backbone.Model
  defaults:
    id: null
    first_name: null
    last_name: null
    
  full_name:()->
    return "#{@get('first_name')} #{@get('last_name')} "

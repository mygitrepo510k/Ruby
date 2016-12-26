class Hircle.Models.Activity extends Backbone.Model
  defaults:
    timeline: null
    activities:[]

class Hircle.Collections.ActivitiesCollection extends Backbone.Collection
  model: Hircle.Models.Activity
  #url: '/departments/1/activities.json'


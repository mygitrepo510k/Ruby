class Hircle.Models.Job extends Backbone.Model
  paramRoot: 'job'

  defaults:
    title: null
    description: null
    city: null
    state: null
    zip: null
    field: null
    tag: null
    visibility: null
    logo: null

class Hircle.Collections.JobsCollection extends Backbone.Collection
  model: Hircle.Models.Job
  url: '/submit_step_one'

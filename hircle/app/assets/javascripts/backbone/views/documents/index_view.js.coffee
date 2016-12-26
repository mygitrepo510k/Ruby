Hircle.Views.Documents ||= {}

class Hircle.Views.Documents.IndexView extends Backbone.View
  template: JST["backbone/templates/documents/index"]

  initialize: () ->
    @options.documents.bind('reset', @addAll)

  
  
  addAll: () =>
    @options.documents.each(@addOne)

  addOne: (document) =>
    view = new Hircle.Views.Documents.DocumentView({model : document})
    @$("#meta_document_list").append(view.render().el)

  render: =>
    $(@el).html(@template(documents: @options.documents.toJSON() ))
    @addAll()

    return this

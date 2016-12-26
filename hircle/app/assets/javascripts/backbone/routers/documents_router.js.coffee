class Hircle.Routers.DocumentsRouter extends Backbone.Router
  initialize: (options) ->
    @documents = new Hircle.Collections.DocumentsCollection()
    @documents.reset options.documents

  routes:
    "new"      : "newDocument"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newDocument: ->
    @view = new Hircle.Views.Documents.NewView(collection: @documents)
    $("#documents").html(@view.render().el)

  index: ->
    @view = new Hircle.Views.Documents.IndexView(documents: @documents)
    $("#documents").html(@view.render().el)

  show: (id) ->
    document = @documents.get(id)

    @view = new Hircle.Views.Documents.ShowView(model: document)
    $("#documents").html(@view.render().el)

  edit: (id) ->
    document = @documents.get(id)

    @view = new Hircle.Views.Documents.EditView(model: document)
    $("#documents").html(@view.render().el)

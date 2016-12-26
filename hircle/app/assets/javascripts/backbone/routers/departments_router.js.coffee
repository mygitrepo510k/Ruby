class Hircle.Routers.DepartmentsRouter extends Backbone.Router
  initialize: (options) ->
    @departments = new Hircle.Collections.DepartmentsCollection()
    @departments.reset options.departments

  routes:
    "new"      : "newDepartment"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"
    "uploadsuccess/:id": "uploadsuccessHandle"
    
  newDepartment: ->
    @view = new Hircle.Views.Departments.NewView(collection: @departments)
    $("#departments").html(@view.render().el)

  index: ->
    @view = new Hircle.Views.Departments.IndexView(departments: @departments)
    $("#departments").html(@view.render().el)

  show: (id) ->
    department = @departments.get(id)

    @view = new Hircle.Views.Departments.ShowView(model: department)
    $("#departments").html(@view.render().el)

  edit: (id) ->
    department = @departments.get(id)

    @view = new Hircle.Views.Departments.EditView(model: department)
    $("#departments").html(@view.render().el)

  uploadsuccessHandle: (department_id) ->
       console.log 'this is upload success.'
        #show document meta page
    
       $("#left_meta_menu").empty()   
       console.log "department id is :"+department_id
       #departments/:id/documents
       url="/departments/"+department_id+"/documents.json"
       paras={}   
       data=[]
       $.ajaxSetup({async:false})
       $.getJSON(url, paras, (json, resp) -> 
                console.log "get documents of department success"               
                data=json                      
       )      
       $.ajaxSetup({async:true})
       documentsCollection = new Hircle.Collections.DocumentsCollection(data)
       indexView = new Hircle.Views.Documents.IndexView(documents:documentsCollection)     
       @$("#left_meta_menu").html(indexView.render().el)
       
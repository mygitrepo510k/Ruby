Hircle.Views.Departments ||= {}

class Hircle.Views.Departments.IndexView extends Backbone.View
  template: JST["backbone/templates/departments/index"]

  initialize: () ->     
    @options.departments.bind('reset', @addAll,this)
    @options.departments.bind('add', @render,this)
    
  addAll: () =>
    @options.departments.each(@addOne)

  addOne: (department) =>
    view = new Hircle.Views.Departments.DepartmentView({model : department})
    #@$("tbody").append(view.render().el)
    @$("#departments_list").append(view.render().el)   
    
  events:
    "click #department_save_btn": "save"
    "click .active": "clickDepartment"
    "click #department_employee_left_menu": "clickEmployeeMenu"
    "click #department_document_left_menu": "clickDocumentMenu"
    "click #department_conversation_left_menu": "clickConversationMenu"
    
  save: (e) ->
    e.preventDefault()
    #e.stopPropagation()  
    $.ajaxSetup({async:false})
    one=null
    $.post('/departments.json', $('#new-department').serialize(), (json, textStatus) ->
              console.log "add new department"
              console.log json
              one=json
    )      
    @options.departments.add(one)
    $.ajaxSetup({async:true})
    #clear input
    $("#department_new_name").val("")
    

  clickConversationMenu: (e) ->
       $("#department_center_page").off();
       $("#department_center_page").empty();
       department_id=$("#selected_department_id").val()
       if department_id==null || department_id==""
         console.log "department id is empty"
         return
       console.log "department id is :"+department_id      
       url="/departments/"+department_id+"/activities.json"
       data=[]
       $.ajaxSetup({async:false})
       $.getJSON(url, null, (json, resp) -> 
                console.log "get activities success"
                console.log json
                data=json                      
       )
       console.log "after get json"
       console.log data
       $.ajaxSetup({async:true})
       @activitiesCollection = new Hircle.Collections.ActivitiesCollection(data)  
       console.log '---------size of activities VO----'
       console.log @activitiesCollection.length       
       activity_index = new Hircle.Views.Activities.IndexView(activities:@activitiesCollection)
       @$("#department_center_page").html(activity_index.render().el)

  clickDocumentMenu: (e) ->
       #show document meta page
       $("#left_meta_menu").off()
       $("#left_meta_menu").empty()
   
       console.log "department id is :"+$("#selected_department_id").val()
       #departments/:id/documents
       url="/departments/"+$("#selected_department_id").val()+"/documents.json"
       paras={}   
       data=[]
       $.ajaxSetup({async:false})
       $.getJSON(url, paras, (json, resp) -> 
                console.log "get documents of department success"
                console.log json
                data=json                      
       )      
       $.ajaxSetup({async:true})
       documentsCollection = new Hircle.Collections.DocumentsCollection(data)
       indexView = new Hircle.Views.Documents.IndexView(documents:documentsCollection)     
       @$("#left_meta_menu").html(indexView.render().el)
     

  clickEmployeeMenu: (e) ->
       $("#department_center_page").off();
       $("#department_center_page").empty();
       console.log "department id is :"+$("#selected_department_id").val()
       #Query employees under department
       #/departments/1/employees.json
       url="/departments/"+$("#selected_department_id").val()+"/employees.json"
       paras={}
   
       data=[]
       $.ajaxSetup({async:false})
       $.getJSON(url, paras, (json, resp) -> 
                console.log "get employees of department success"
                console.log json
                data=json                      
       )      
       $.ajaxSetup({async:true})
       employeesCollection = new Hircle.Collections.EmployeesCollection(data)
       viewEmployee = new Hircle.Views.Employees.IndexView()
       viewEmployee.employees=employeesCollection
       @$("#department_center_page").html(viewEmployee.render().el)
                      
   clickDepartment: (e) ->
       $("#department_center_page").off()
       $("#department_center_page").empty()
       console.log "click a department" 
       #$(event.target).data('name')
       console.log  e.target
       #console.log e.target.departmentid
       department_id=$(e.target).attr("departmentid")     
       console.log department_id
        #selected department
       $("#selected_department_id").val(department_id)
       #Load activity of department
       #data=[{"timeline":"Today","activities":[{"activity_id":2,"type":"conversation","time_short":"14 hours ago","from":"Mack Chen","activity_by_id":1,"to":["Mack Chen"],"comments":[]}]},{"timeline":"Yesterday","activities":[{"activity_id":1,"type":"upload file","time_short":"38 hours ago","from":"Mack Chen","activity_by_id":1,"to":["Mack Chen"],"comments":[]}]}]
       #the fetch of collection is async.FUCK.
       url="/departments/"+department_id+"/activities.json"
       data=[]
       $.ajaxSetup({async:false})
       $.getJSON(url, null, (json, resp) -> 
                console.log "get activities success"
                console.log json
                data=json                      
       )
       console.log "after get json"
       console.log data
       $.ajaxSetup({async:true})
       @activitiesCollection = new Hircle.Collections.ActivitiesCollection(data)  
       console.log '---------size of activities VO----'
       console.log @activitiesCollection.length       
       activity_index = new Hircle.Views.Activities.IndexView(activities:@activitiesCollection)
       @$("#department_center_page").html(activity_index.render().el)
       #@activitiesCollection = new Hircle.Collections.ActivitiesCollection()      
       #@activitiesCollection.bind('refresh',Hircle.Views.Activities.ActivityView.render)     
       #@activitiesCollection.fetch().complete(@success(@activitiesCollection))   
       #$.when(@activitiesCollection.fetch()).then(@success(@activitiesCollection))
       #Modify department 
       console.log "modify department manager"
       console.log @options.departments
       depart=@options.departments.where(id:parseInt(department_id))
       console.log depart[0]
       #department_name
       $("#department_name").text(depart[0].get("name")+"  Department")
       $("#department_manager").text(depart[0].get("manager"))
       $("#department_employee").text(depart[0].get("employees"))
       $("#department_tasks").text(depart[0].get("tasks"))
       $("#department_documents").text(depart[0].get("documents"))
      
       
       
  render: =>   
    $(@el).html(@template(departments: @options.departments.toJSON() ))
    @addAll()

    return this

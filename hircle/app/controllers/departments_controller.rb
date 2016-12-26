class DepartmentsController < ApplicationController
  # GET /departments
  # GET /departments.json
  def index
    #find administrator of the department
    #The company's ID should be catch from session or request url.
    company_id=(params[:id].nil?)?1:params[:id]
     manager = User.find(:first, 
        :joins => [:role], 
        :select => "users.first_name as first,users.last_name as last", 
        :conditions => ["users.company_id=? and roles.name='Admin'",company_id]
      ) 
      
     departments=Department.find_by_sql(["select d.id,d.name,(select count(users.id) from users where users.department_id=d.id) as employees,
     (select count(tasks.id) from tasks where d.id=tasks.department_id) as tasks,
     (select count(resources.id) from resources where resources.department_id=d.id) as resources 
      from departments d where d.company_id = ?",company_id])
     
     @departments=[] #This is actually view object
     departments.each do |department|
        statistical=ProtocolJsonHelper::Statistical.new
        statistical.manager=(manager.nil?)?"":(manager['first']+' '+manager['last'])
         statistical.id=department['id']
         statistical.name=department['name']
         statistical.employees=department['employees']
         statistical.tasks=department['tasks']
         statistical.documents=department['resources']  
         @departments << statistical
     end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departments }
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @department }
    end
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @department }
    end
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # POST /departments.json
  def create
    if !params[:company_id].nil?
       params[:department][:company_id] = params[:company_id]
    end
    #logger.debug  '------------------------------------------------------'+params[:department].to_json
    @department = Department.new(params[:department])
   
    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render json: @department, status: :created, location: @department }
      else
        format.html { render action: "new" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end
  
  #definition view of employee 
  #class Employee
  #  attr_accessor :id,:email,:thumbnail,:status,:name,:tasks,:documents,:profile
  #end  
  # GET /departments/employees
  # GET /departments/employees.json
  def employees
    
    users=User.includes(:resources, :tasks, :profile).where("users.department_id = ? ",params[:id])
    @employess=[]
    users.each do |user|
      employee=ProtocolJsonHelper::Employee.new
      employee.id=user.id       
      employee.email=user.email
      employee.thumbnail=user.avatar.url(:thumb)
      employee.status=user.status
      employee.name=user.first_name+' '+user.last_name  
      employee.tasks=user.tasks
      employee.documents=user.resources
      employee.profile=(user.profile.nil?)?{}:user.profile
      @employess << employee
    end
    
    respond_to do |format|
      format.html # query_statistical_datas.html.erb
      format.json { render json: @employess }
    end    
    
  end
  # GET /departments/addemployees
  # GET /departments/addemployees.json
  def addemployees   
   
     params[:ids].each_line(","){
       |id|
       auser=User.find(id)
       auser.update_attributes(:department_id => params[:department_id])
     }
     respond_to do |format|
      #format.html # 
      format.json { render json: "ok" }
    end    
  end
  # GET /departments/documents
  # GET /departments/documents.json
  def documents
    files=Resource.where("department_id = ? ",params[:id]) 
    @resources=[]
    files.each do |resource|
      resource.pointer=resource.full_path
      @resources << resource
    end
    respond_to do |format|
      format.html 
      format.json { render json: @resources }
    end    
  end  
  
  
  # GET /departments/activities
  # GET /departments/activities.json
  def activities   
    timelines={0=>"Today",1=>"Yesterday",2=>"Before"}
    activities=Activity.includes(:assignor,:assignee,:comments => :user).where("activities.department_id=? and activities.create_date BETWEEN ? AND ? ",params[:id],Time.now - 2.day,Time.now).order("activities.create_date DESC")
    
    #Key is timeline
    #value is array of ActivityViews
    #Data group by key
    #:time line,:activities
    activities_hash={}     
    activities.each do |activity|
      days=((Time.now - activity.create_date) / 1.day).to_i
     
      view=ProtocolJsonHelper::ActivityView.new  
      view.activity_id=activity.id
      view.type=activity.activity_type      
      #time short  
      #((Time.now - activity.create_date) /(1*60*60)).to_i.to_s+' hours ago'
      view.time_short=((Time.now - activity.create_date) /(1*60*60)).to_i.to_s+' hours ago'  
      assignor=activity.assignor
      view.from=assignor.first_name+' '+assignor.last_name
      view.activity_by_id=assignor.id
      
      assignee=activity.assignee
      view.to=[assignee.first_name+' '+assignee.last_name]      
      #create multiple comments     
      #For high performance,the comments are could be loaded alone.such as activities/1/comments.json      
      view.comments=buildCommentView(activity.comments)     
      #Base the key to append activity view to the value.
      #The value is a array
      timeline=timelines[days]
      if activities_hash.has_key?(timeline)
        origin=activities_hash[timeline]
        values_array=(origin.nil?)?[]:origin
        values_array << view
      else
        #new array of values
        #insert key and values into hash
        activity_views=[]
        activity_views << view
        activities_hash[timeline]=activity_views
      end
     
    end
    #group activities
    #activity screen
    @array=[]
    activities_hash.each do |key, value|     
      screen=ProtocolJsonHelper::ActivityScreen.new
      screen.timeline=key
      screen.activities=value
      @array << screen
    end
    
    respond_to do |format|
      #format.html 
      format.json { render json: @array }
    end
  end
  #recursive to get comments
  private
  def buildCommentView(comments)
     comment_views=[]
      comments.each do |comment|
          #new view and sons of comment
          commentview=ProtocolJsonHelper::CommentView.new
          commentview.comment_id=comment.id
          commentview.activity_id=comment.activity_id
          creator=comment.user          
          commentview.user_id=creator.id
          commentview.name=creator.full_name     
          commentview.thumbnail=creator.avatar.url(:thumb)
          #time short
          commentview.time_short=((Time.now - comment.create_at) /(1*60*60)).to_i.to_s+' hours ago' 
          commentview.content=comment.content
          commentview.replys=buildCommentView(comment.comments)         
          comment_views << commentview                
      end
      return comment_views
  end
  
end

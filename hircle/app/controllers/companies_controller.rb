class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
 
  # GET /companies/employees
  # GET /companies/employees.json
  def employees
    users=nil
    #Query the users are not included in any department.
    #special parameter q.    
    name=(params[:name].nil?)?params[:q]:params[:name]
    if name.nil?
      users=User.includes(:resources, :tasks ,:profile).where(" users.department_id is NULL and users.company_id = ? ",params[:id])
    else
      users=User.includes(:resources, :tasks ,:profile).where(" users.department_id is NULL and users.company_id = ? and ( users.first_name like ? or users.last_name like ? )",params[:id],"%#{name}%","%#{name}%")
    end

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
      format.html # 
      format.json { render json: @employess }
    end
  
  end

  # query statistical and info company
  # GET /companies/departments
  # GET /companies/departments.json
  def departments
   
      manager = User.find(:first, 
        :joins => [:role], 
        :select => "users.first_name as first,users.last_name as last", 
        :conditions => ["users.company_id=? and roles.name='Admin'",company_id]
      )   
      
     departments=Department.find_by_sql(["select d.id,d.name,(select count(users.id) from users where users.department_id=d.id) as employees,
     (select count(tasks.id) from tasks where d.id=tasks.department_id) as tasks,
     (select count(resources.id) from resources where resources.department_id=d.id) as resources 
      from departments d where d.company_id = ?",params[:id]])
     
      @statisticals=[]
     departments.each do |department|
        statistical=ProtocolJsonHelper::Statistical.new
        statistical.manager=manager['first']+' '+manager['last']
     statistical.id=department['id']
     statistical.name=department['name']
     statistical.employees=department['employees']
     statistical.tasks=department['tasks']
     statistical.documents=department['resources']  
     @statisticals << statistical
     end
    
     respond_to do |format|
      format.html # query_statistical_datas.html.erb
      format.json { render json: @statisticals }
    end
  end
end

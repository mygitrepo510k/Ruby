class TasksController < ApplicationController

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
     
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end


  def index
    @tasks = current_user.tasks
    
    #@tasks = Task.scoped  
    #@tasks = Task.between(params[:start], params[:end]) if (params[:start] && params[:end])  

    respond_to do |format|
      format.html
      format.json {render :json => @tasks } 
    end
  end
  
  def create
    task = current_user.tasks.build(params[:task])
    if task.save
      params[:assignee].each do |i|
        task.assignments.create(:assignee_id => i)
      end if params[:assignee]
      respond_to do |format|
        format.html
        format.json {render :json => {:message => "task saved successfully"}}
      end
    else
      respond_to do |format|
        format.html
        format.json {render :json => {:message => "task not saved successfully"}}

      end
    end
  end

  def update
     @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path , notice: 'Task was successfully updated.' }
        format.json { render json: @task }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])    
    @task.destroy
    
    respond_to do |format|
       format.html { redirect_to tasks_url }
    end
  end 
  
end

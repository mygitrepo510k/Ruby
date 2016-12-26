class DashboardController < ApplicationController
  def index
    @jobs = Job.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def employer_jobs    
    if current_user
      @jobs = Job.where(:user_id => current_user.id)
    else
      @jobs = []
    end    
    
    respond_to do |format|
      format.html
    end
  end  
  
  def new_job_post
    @job = Job.new
     
    respond_to do |format|
      format.html
    end      
  end
  def job_applicants
    
  end
  def submit_step_one
    @job = Job.new(params[:job])
    @job.user = current_user
    respond_to do |format|
     if @job.save
       format.html { render "submit_step_two" }
     else       
       format.html { render "new_job_post" }
     end     
    end      
  end
  
  def submit_step_two
    @job = Job.find(params[:job_id])
    
    respond_to do |format|
     if @job.update_attributes(:visibility => params[:visibility],:field => params[:field],
                                     :tag => params[:tag] )
      redirect_to :employer_jobs
      return
     else       
       format.html { render "new_job_post" }
     end     
    end      
  end 
  
  def show_job
    @job = Job.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def get_user
    @users = User.where("first_name LIKE ?", "%#{params[:user]}%")
    
    render :json => @users.to_json    
  end
  
  def task_board
    #@tasks = current_user.tasks
    
    @tasks = Task.scoped  
    @tasks = Task.between(params[:start], params[:end]) if (params[:start] && params[:end])  

    respond_to do |format|
      format.html
      format.json {render :json => @tasks } 
    end
  end
end

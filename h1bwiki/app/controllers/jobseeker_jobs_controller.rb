class JobseekerJobsController < ApplicationController
  before_filter :require_login_job_seeker, :except => [ :index, :show ]
  # GET /jobseeker_jobs
  # GET /jobseeker_jobs.json
  def index
    redirect_to jobseeker_posts_path and return
    @jobseeker_jobs = current_user.jobseeker_jobs.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobseeker_jobs }
    end
  end

  # GET /jobseeker_jobs/1
  # GET /jobseeker_jobs/1.json
  def show    
    @jobseeker_job = JobseekerJob.find(params[:id])
    
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    @captcha = (0...6).map{ o[rand(o.length)] }.join

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobseeker_job }
    end
  end

  # GET /jobseeker_jobs/new
  # GET /jobseeker_jobs/new.json
  def new
    @jobseeker_job = JobseekerJob.new
    session[:cur_tab] = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobseeker_job }
    end
  end

  # GET /jobseeker_jobs/1/edit
  def edit
    @jobseeker_job = JobseekerJob.find(params[:id])
  end
  
  # POST /jobseeker_job
  # POST /jobseeker_job.json
  def preview
    @jobseeker_job = JobseekerJob.new(params[:jobseeker_job])

    respond_to do |format|
      format.html # preview.html.erb
      format.json { render json: @jobseeker_job }
    end
  end
  
  # POST /jobseeker_jobs
  # POST /jobseeker_jobs.json
  def create
    @jobseeker_job = JobseekerJob.new(params[:jobseeker_job])

    respond_to do |format|
      if @jobseeker_job.save
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker job was successfully created.' }
        format.json { render json: @jobseeker_job, status: :created, location: @jobseeker_job }
      else
        format.html { render action: "new" }
        format.json { render json: @jobseeker_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobseeker_jobs/1
  # PUT /jobseeker_jobs/1.json
  def update
    @jobseeker_job = JobseekerJob.find(params[:id])

    respond_to do |format|
      if @jobseeker_job.update_attributes(params[:jobseeker_job])
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobseeker_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobseeker_jobs/1
  # DELETE /jobseeker_jobs/1.json
  def destroy
    @jobseeker_job = JobseekerJob.find(params[:id])
    @jobseeker_job.destroy

    respond_to do |format|
      format.html { redirect_to jobseeker_jobs_url }
      format.json { head :no_content }
    end
  end
end

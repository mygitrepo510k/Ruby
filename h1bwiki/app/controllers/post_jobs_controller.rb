class PostJobsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show ]
  # GET /post_jobs
  # GET /post_jobs.json
  def index
    redirect_to posts_view_path and return
    @post_jobs = current_user.post_jobs.paginate(:page => params[:page], :per_page => 10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_jobs }
    end
  end

  # GET /post_jobs/1
  # GET /post_jobs/1.json
  def show
    @post_job = PostJob.find(params[:id])
    @applicants = Applicant.new
    @applicants.pictures.build
    
    @applicant = Applicant.where(:user_id=>current_user.id, :post_job_id=>params[:id]).first if current_user
    
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    @captcha = (0...6).map{ o[rand(o.length)] }.join

    flash[notice] = nil
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_job }
    end
  end

  # GET /post_jobs/new
  # GET /post_jobs/new.json
  def new
    @post_job = PostJob.new
    @post_job.skills.build
    @post_job.work_authorizations.build
    session[:cur_tab] = 0
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_job }
    end
  end

  # GET /post_jobs/1/edit
  def edit
    @post_job = PostJob.find(params[:id])
    @post_job.skills.build if @post_job.skills.nil?
    @post_job.work_authorizations.build @post_job.work_authorizations.blank?
  end

  # POST /post_jobs
  # POST /post_jobs.json
  def create
    flash[:cur_tab] = 0

    @post_job = PostJob.new(params[:post_job])

    respond_to do |format|
      if @post_job.save
        format.html { redirect_to posts_view_path, notice: 'Success! Your Job Posting is Created' }
        format.json { render json: @post_job, status: :created, location: @post_job }
      else
        format.html { render action: "new" }
        format.json { render json: @post_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_jobs/1
  # PUT /post_jobs/1.json
  def update
    @post_job = PostJob.find(params[:id])
    
    if params[:post_job][:job_type] == '0'
      params[:post_job][:job_duration] = ''
      params[:post_job][:hourly_rate] = ''
    else
      params[:post_job][:salary] = nil
    end
    
    #render :text=>params[:post_job][:work_authorizations_attributes].inspect and return
    @post_job.work_authorizations.each do |wa|
      wa.destroy
    end
    
    respond_to do |format|
      if @post_job.update_attributes(params[:post_job])
        format.html { redirect_to posts_view_path, notice: 'Success! Your Job Posting is Updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /post_jobs
  # POST /post_jobs.json
  def preview
    @post_job = PostJob.new(params[:post_job])
    #render :text => params[:post_job].inspect and return
    respond_to do |format|
      format.html # preview.html.erb
      format.json { render json: @post_job }
    end
  end

  # DELETE /post_jobs/1
  # DELETE /post_jobs/1.json
  def destroy
    @post_job = PostJob.find(params[:id])
    @post_job.destroy

    respond_to do |format|
      format.html { redirect_to posts_view_path }
      format.json { head :no_content }
    end
  end
end

class JobseekerMentorsController < ApplicationController
  before_filter :require_login_job_seeker, :except => [ :index, :show ]
  # GET /jobseeker_mentors
  # GET /jobseeker_mentors.json
  def index
    redirect_to jobseeker_posts_path and return
    @jobseeker_mentors = current_user.jobseeker_mentors.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobseeker_mentors }
    end
  end

  # GET /jobseeker_mentors/1
  # GET /jobseeker_mentors/1.json
  def show
    @jobseeker_mentor = JobseekerMentor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobseeker_mentor }
    end
  end

  # GET /jobseeker_mentors/new
  # GET /jobseeker_mentors/new.json
  def new
    @jobseeker_mentor = JobseekerMentor.new
    session[:cur_tab] = 2
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobseeker_mentor }
    end
  end

  # GET /jobseeker_mentors/1/edit
  def edit
    @jobseeker_mentor = JobseekerMentor.find(params[:id])
  end
  
  # POST /jobseeker_job
  # POST /jobseeker_job.json
  def preview
    @jobseeker_mentor = JobseekerMentor.new(params[:jobseeker_mentor])
    
    respond_to do |format|
      format.html # preview.html.erb
      format.json { render json: @jobseeker_mentor }
    end
  end

  # POST /jobseeker_mentors
  # POST /jobseeker_mentors.json
  def create
    @jobseeker_mentor = JobseekerMentor.new(params[:jobseeker_mentor])

    respond_to do |format|
      if @jobseeker_mentor.save
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker mentor was successfully created.' }
        format.json { render json: @jobseeker_mentor, status: :created, location: @jobseeker_mentor }
      else
        format.html { render action: "new" }
        format.json { render json: @jobseeker_mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobseeker_mentors/1
  # PUT /jobseeker_mentors/1.json
  def update
    @jobseeker_mentor = JobseekerMentor.find(params[:id])

    respond_to do |format|
      if @jobseeker_mentor.update_attributes(params[:jobseeker_mentor])
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker mentor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobseeker_mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobseeker_mentors/1
  # DELETE /jobseeker_mentors/1.json
  def destroy
    @jobseeker_mentor = JobseekerMentor.find(params[:id])
    @jobseeker_mentor.destroy

    respond_to do |format|
      format.html { redirect_to jobseeker_mentors_url }
      format.json { head :no_content }
    end
  end
end

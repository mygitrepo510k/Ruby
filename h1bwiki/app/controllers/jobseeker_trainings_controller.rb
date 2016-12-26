class JobseekerTrainingsController < ApplicationController
  before_filter :require_login_job_seeker, :except => [ :index, :show ]
  # GET /jobseeker_trainings
  # GET /jobseeker_trainings.json
  def index
    redirect_to jobseeker_posts_path and return
    @jobseeker_trainings = current_user.jobseeker_trainings.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobseeker_trainings }
    end
  end

  # GET /jobseeker_trainings/1
  # GET /jobseeker_trainings/1.json
  def show
    @jobseeker_training = JobseekerTraining.find(params[:id])
    
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    @captcha = (0...6).map{ o[rand(o.length)] }.join

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobseeker_training }
    end
  end

  # GET /jobseeker_trainings/new
  # GET /jobseeker_trainings/new.json
  def new
    @jobseeker_training = JobseekerTraining.new
    session[:cur_tab] = 1

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobseeker_training }
    end
  end

  # GET /jobseeker_trainings/1/edit
  def edit
    @jobseeker_training = JobseekerTraining.find(params[:id])
  end
  # POST /jobseeker_job
  # POST /jobseeker_job.json
  def preview
    @jobseeker_training = JobseekerTraining.new(params[:jobseeker_training])

    respond_to do |format|
      format.html # preview.html.erb
      format.json { render json: @jobseeker_training }
    end
  end

  # POST /jobseeker_trainings
  # POST /jobseeker_trainings.json
  def create
    @jobseeker_training = JobseekerTraining.new(params[:jobseeker_training])

    respond_to do |format|
      if @jobseeker_training.save
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker training was successfully created.' }
        format.json { render json: @jobseeker_training, status: :created, location: @jobseeker_training }
      else
        format.html { render action: "new" }
        format.json { render json: @jobseeker_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobseeker_trainings/1
  # PUT /jobseeker_trainings/1.json
  def update
    @jobseeker_training = JobseekerTraining.find(params[:id])

    respond_to do |format|
      if @jobseeker_training.update_attributes(params[:jobseeker_training])
        format.html { redirect_to jobseeker_posts_path, notice: 'Jobseeker training was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobseeker_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobseeker_trainings/1
  # DELETE /jobseeker_trainings/1.json
  def destroy
    @jobseeker_training = JobseekerTraining.find(params[:id])
    @jobseeker_training.destroy

    respond_to do |format|
      format.html { redirect_to jobseeker_trainings_url }
      format.json { head :no_content }
    end
  end
end

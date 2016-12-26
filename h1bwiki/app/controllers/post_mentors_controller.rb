class PostMentorsController < ApplicationController
  before_filter :require_login_employer, :except => [ :index, :show ]
  # GET /post_mentors
  # GET /post_mentors.json
  def index
    redirect_to posts_view_path and return
    @post_mentors = current_user.post_mentors.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_mentors }
    end
  end

  # GET /post_mentors/1
  # GET /post_mentors/1.json
  def show
    @post_mentor = PostMentor.find(params[:id])
    flash[notice] = nil
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_mentor }
    end
  end

  # GET /post_mentors/new
  # GET /post_mentors/new.json
  def new
    @post_mentor = PostMentor.new
    @post_mentor.skills.build
    session[:cur_tab] = 2
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_mentor }
    end
  end

  # GET /post_mentors/1/edit
  def edit
    @post_mentor = PostMentor.find(params[:id])
    @post_mentor.skills.build if @post_mentor.skills.nil?
  end

  # POST /post_mentors
  # POST /post_mentors.json
  def create
    @post_mentor = PostMentor.new(params[:post_mentor])

    respond_to do |format|
      if @post_mentor.save
        format.html { redirect_to posts_view_path, notice: 'Success! Your Mentor Assistance Posting is Created' }
        format.json { render json: @post_mentor, status: :created, location: @post_mentor }
      else
        format.html { render action: "new" }
        format.json { render json: @post_mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_mentors/1
  # PUT /post_mentors/1.json
  def update
    @post_mentor = PostMentor.find(params[:id])

    respond_to do |format|
      if @post_mentor.update_attributes(params[:post_mentor])
        format.html { redirect_to posts_view_path, notice: 'Success! Your Mentor Assistance Posting is Updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_mentor.errors, status: :unprocessable_entity }
      end
    end
  end
  # POST /post_mentors/preview
  def preview
    @post_mentor = PostMentor.new(params[:post_mentor])
    respond_to do |format|
      format.html # preview.html.haml
      format.json { render json: @post_mentor }
    end
  end
  # DELETE /post_mentors/1
  # DELETE /post_mentors/1.json
  def destroy
    @post_mentor = PostMentor.find(params[:id])
    @post_mentor.destroy

    respond_to do |format|
      format.html { redirect_to posts_view_path }
      format.json { head :no_content }
    end
  end
end

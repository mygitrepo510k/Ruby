class Admin::ExperiencesController < ApplicationController
	before_filter :require_admin
  respond_to :json, only: :add_follower

  def index
    @experiences = Experience
      .where(program: current_user.current_program)
      .order('created_at desc').paginate page: params[:page]
  end

  def new
    @experience = Experience.new
  end

  def create
    scheduled_for = !(params[:experience][:scheduled_for] == '') ? DateTime.strptime(params[:experience][:scheduled_for], "%m/%d/%Y %H:%M") : ''
    @experience = Experience.create(params[:experience]
      .merge({ created_by: current_user, program: current_user.current_program, scheduled_for: scheduled_for }).except('created_for'))
    if @experience.valid?
      redirect_to @experience, notice: 'Experience created' and return
    else
      render :new
    end
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    @experience.update(params[:experience].except('created_for').merge(
      { scheduled_for: DateTime.strptime(params[:experience][:scheduled_for], "%m/%d/%Y %H:%M") } ))
    redirect_to @experience, notice: 'Experience updated'
  end

  def add_follower
    exp = Experience.find(params[:experience_id])
    begin
      exp.followers << User.find(params[:experience_follower][:user])
    rescue
      flash[:info] = 'User is already following this experience'
    end
    redirect_to exp
  end

  def destroy
    Experience.find(params[:id]).destroy
		redirect_to admin_experiences_path, notice: 'Experience deleted'
  end
end

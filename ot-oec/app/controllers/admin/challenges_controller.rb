class Admin::ChallengesController < ApplicationController
  before_filter :require_admin

  def index
    @challenges = Challenge
      .where(program: current_user.current_program)
      .order('created_at desc').paginate page: params[:page]
  end

  def create
    @challenge = Challenge.create(params[:challenge]
      .merge({ created_by: current_user, program: current_user.current_program }))
    if @challenge.valid?
      User.created_new_challenge(@challenge)
      redirect_to challenge_path(@challenge), notice: 'Challenge was successfuly created!'
    else
      render :new
    end
  end

  def new
    @challenge = Challenge.new
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def show
  end

  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      redirect_to challenge_path(@challenge), notice: 'Challenge was successfuly updated!'
    else
      render :edit
    end
  end

  def destroy
  end
end

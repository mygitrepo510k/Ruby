class Admin::PodsController < ApplicationController
	before_filter :require_leader
  respond_to :json, only: [:update]

  def index
    @pods = Pod.where(program: current_user.current_program).paginate page: params[:page]
  end

  def show
    @pod = Pod.find(params[:id])
  end

  def update
    @pod = Pod.find(params[:id])
    unless @pod.leader == current_user or current_user.admin?
      render plain: 'You cannot update this pod\'s info', status: :unauthorized and return
    end
    if @pod.update(params[:pod])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
end

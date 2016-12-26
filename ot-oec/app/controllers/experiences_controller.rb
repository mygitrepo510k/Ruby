class ExperiencesController < ApplicationController
	before_filter :require_login
	before_filter :allowed_users, only: [:show, :excuted]
  respond_to :json, only: [:update]

	def show
		common_layout_support
		@experience = Experience.find(params[:id])
    if @experience.private and @experience.created_for != current_user and !current_user.admin?
      redirect_to root_path, notice: 'This content is private' and return
    end
	end

	def index
	end

	def executed
		exp = Experience.find(params[:id])
		exp.update!(executed_by: current_user, executed_at: DateTime.now)
		redirect_to exp
	end

	def allowed_users
		exp = Experience.find(params[:id])
		viewable = (current_user.admin? or exp.followers.exists?(current_user) or (exp.executed_at and (exp.created_for == current_user or !exp.made_private)))
		if !viewable; redirect_to root_path, notice: 'This content is private'; end
	end

  def update
    @experience = Experience.find(params[:id])
		render json: { success: @experience.update(hash_to_ints(params[:experience])), data: @experience }
  end
end

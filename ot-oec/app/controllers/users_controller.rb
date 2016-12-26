class UsersController < ApplicationController
	require 'typeform_helper'
	before_filter :require_login, except: [:confirm, :set_password]

	def confirm
		unless @user = User.find_by(confirmation_token: params[:token])
			flash[:info] = 'This link has expired. Your account is already active.'
			redirect_to root_path and return
    end

    if @user.activated
      @user.current_program = @user.programs.last
      @user.confirmation_token = nil
      @user.save

      sign_in(:user, @user)
      flash[:notice] = 'You have been added to the %s program' % @user.current_program.name
      redirect_to root_path and return
    end
	end

  def set_password
    @user = User.find(params[:user][:id])
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.confirmation_token = nil
    @user.activated = true
    @user.save!

    sign_in(:user, @user)
    redirect_to root_path, notice: 'Your account has been set up successfully!'
  end

	def index
		@users = current_user.current_program.users.order(:name)
	end

	def change_safeword
		user = User.find(params[:id])
		if user != current_user; redirect_to user, alert: 'you can only change the safeword for your profile'; return; end
		prog = user.user_programs.find_by(program: current_user.current_program)
		prog.update!(safeword: params[:word])
		if params[:word] == 'red'
			UserMailer.safeword_red_email(user, prog).deliver
		end
		redirect_to user, notice: 'safeword updated'
	end

	def show
		common_layout_support
		@user = User.find(params[:id])
		cu = current_user
		@pod = @user.pods.find_by(program: cu.current_program)
		@user_program = @user.user_programs.find_by(program: cu.current_program)
		@challenges = Challenge.where(program: cu.current_program)

		# todo: there must be a more elegent way to do this...
		if current_user.admin?
			@experiences = Experience.where(created_for: @user)
		elsif current_user.admin?
			# todo: create the appropriate query
			# http://stackoverflow.com/questions/3639656/activerecord-or-query
			# Experience.includes(:followers).where(created_for: @user).where(experience_followers: { user: @user}).or.where("(executed_at IS NOT NULL) AND (made_private = 'f')")
			@experiences = Experience.where(created_for: @user)
		end

		@profile = TypeFormHelper.intake_answers(@user.current_program, @user, false)
	end

  def update
    @user = User.find(params[:id])
    unless @user == current_user or current_user.admin?
      render plain: 'You cannot update this user\'s profile', status: :unauthorized and return
    end
    respond_to do |format|
      if @user.update(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end

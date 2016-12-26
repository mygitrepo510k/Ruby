require 'csv'
require 'typeform_helper'

class Admin::UsersController < ApplicationController
	before_filter :require_admin
  respond_to json: :get_intake

	def index
		@users = current_user.current_program.users.order(:name).paginate page: params[:page]
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params[:user].merge!( { location: Location.find(params[:user][:location]) }))
    @user_program = UserProgram.find_by(user: @user, program: current_user.current_program)
    @user_program.update({ role: params[:user_program][:role].to_i })
    if @user.valid? and @user_program.valid?
      redirect_to edit_admin_user_path(@user), notice: 'User updated'
    else
      render :edit
    end
  end

	def new
		@user = User.new
	end

	def create
    unless user = User.create_user_or_add_to_program(params[:user], current_user.current_program, params[:user_program][:role])
      redirect_to new_admin_user_path, notice: 'This user is already part of this program' and return
    end

    user.update_attribute(:confirmation_token, SecureRandom.hex)
		UserMailer.welcome_email(user, current_user.current_program, request.host_with_port).deliver
		redirect_to new_admin_user_path, notice: 'User added to the program'
	end

  def resend_welcome_mail
    @user = User.find(params[:user_id])
    @user.send_welcome_mail(current_user.current_program, request.host_with_port)
    redirect_to @user, notice: 'Welcome email re-sent'
  end

  def get_intake
    user = User.find(params[:user_id])
		profile = TypeFormHelper.intake_answers(current_user.current_program, user, false)

		html = render_to_string(
			template: '/users/_intake.slim', 
			formats: ['html'], layout: false,
			locals: { profile: profile } )
		render json: { html: html }
  end

	def import
	end

  def destroy
    user = User.find(params[:id])

    if user == current_user
      redirect_to user, notice: 'You cannot delete your own profile'
    end

    user.destroy_related
    if user.destroy
      redirect_to users_path, notice: "#{user.name}'s profile has been deleted"
    else
      redirect_to user, notice: 'This user could not be deleted'
    end
  end
end

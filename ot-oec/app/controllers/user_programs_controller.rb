class UserProgramsController < ApplicationController
	before_filter :require_login

  def update
    @userprogram = UserProgram.find(params[:id])
    unless @userprogram.user == current_user
      render plain: 'You cannot update this user\'s profile', status: :unauthorized and return
    end
    respond_to do |format|
      update_params = { private_intake: params[:userprogram] ? true : false }
      if @userprogram.update(update_params)
        format.html { redirect_to @userprogram.user, notice: 'Privacy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @userprogram.errors, status: :unprocessable_entity }
      end
    end
  end
end

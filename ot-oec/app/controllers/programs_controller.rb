class ProgramsController < ApplicationController
	before_filter :require_login

  def switch
    program = Program.find(params[:id])
    unless current_user.programs.exists? program
      redirect_to root_path, notice: 'You cannot switch to this program, you are not in it' and return
    end
    current_user.update_attribute(:current_program, program)
    redirect_to refresh_path
  end

  def refresh
    redirect_to root_path
  end
end

class Admin::ProgramsController < ApplicationController
  before_filter :require_super_admin

  def index
    @programs = Program.paginate page: params[:page]
  end

  def new
    @program = Program.new
  end

  def edit
    @program = Program.find(params[:id])
  end

  def create
    params[:program].merge!({ welcome_email: JSON.generate({ 'markdown' => params[:program][:welcome_email] }) })

    @program = Program.create(params[:program])
    if @program.valid?
      current_user.user_programs << UserProgram.create(program: @program)
      current_user.update_attribute(:current_program, @program)
      current_user.admin! current_user
      redirect_to root_path, notice: 'New program has been created' and return
    else
      render :new
    end
  end

  def update
    @program = Program.find(params[:id])
    params[:program].merge!({ welcome_email: JSON.generate({ 'markdown' => params[:program][:welcome_email] }) })
    @program.update(params[:program])
    render :edit
  end

  def show
  end

  def destroy
    program = Program.find(params[:id])

    unless Program.count > 1
      redirect_to edit_admin_program_path(program), notice: 'You cannot delete the last program' and return
    end

    program = Program.find(params[:id])

    program.users.each do |user|
      user.remove_program program
    end

    program.destroy

		redirect_to admin_programs_path, notice: 'Program has been deleted'
  end
end

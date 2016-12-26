class Admin::AnnouncementsController < ApplicationController
	before_filter :require_admin

  def index
    @announcements = Announcement
      .where(program: current_user.current_program)
      .order(created_at: :desc)
      .paginate page: params[:page]
  end

  def new
    @announcement = Announcement.new
  end

  def create
    params[:announcement].merge!({ created_by: current_user, program: current_user.current_program })
    @announcement = Announcement.create(params[:announcement])
    if @announcement.valid?
      redirect_to admin_announcements_path, notice: 'Announcement has been made to the program'
    else
      render :new
    end
  end

  def update
  end
end

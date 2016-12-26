class AnnouncementsController < ApplicationController
  before_filter :require_login, :common_layout_support

  def show
    @announcement = Announcement.find(params[:id])
    unless @announcement.program.users.exists? current_user
      unauthorized root_path and return
    end
  end
end

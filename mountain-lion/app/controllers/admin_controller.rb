class AdminController < ApplicationController
  layout "admin"
  before_action :require_admin

  private
  def require_admin
    unless current_user && current_user.is_a?(Admin)
      redirect_to root_url, notice: "You are not authorized to access this page"
    end
  end
end

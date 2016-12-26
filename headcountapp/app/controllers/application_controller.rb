class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin
    if !current_user.present?
      redirect_to new_user_session_path
    elsif current_user.present? && current_user.role == "admin"
      # proceed as normal
    else
      flash[:error] = "Access is for admin only"
      redirect_to root_path
    end
  end

  def host_name
    if Rails.env.production?
      "http://headcountapp.herokuapp.com"
    else
      "http://192.168.0.55:3000"
    end
  end
end

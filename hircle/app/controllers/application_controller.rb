class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_gon
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def online
  	if current_user
  		current_user.touch
  	end  
  end

  def set_gon
    gon.assignee_list =  User.select([:first_name,:last_name,:id])
  end
end

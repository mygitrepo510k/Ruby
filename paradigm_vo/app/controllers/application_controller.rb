class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

	def store_location
	  session[:return_to] = request.fullpath if request.get?
	end
	
	def redirect_back_or_default(default)
	  redirect_to(session[:return_to] || default)
	end

	def js_redirect_to(path)
	  render js: %(window.location.href='#{path}') and return
	end

end

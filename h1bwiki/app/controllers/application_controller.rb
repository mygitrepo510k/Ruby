class ApplicationController < ActionController::Base
	protect_from_forgery	
	before_filter :unread_messages_count
	helper_method :employer?
	
	private
	def employer?			
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			current_user.account_type == "employer" ? true : false		
		end
	end

	def require_login_employer
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			if !employer?
				flash[:notice] = 'Sorry, Only an Employer can use this page'
				redirect_to root_url
			end	
		end	
	end
	def require_login_job_seeker
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			if employer?
				flash[:notice] = 'Sorry, Only a Job Seeker can use this page'
				redirect_to root_url
			end	
		end 
	end
	def require_login!
		redirect_to new_user_session_path if !user_signed_in?
	end
	
	def unread_messages_count
		session["unread_message_count"] = current_user.mailbox.inbox(:read => false).count(:id, :distinct => true) if current_user.present?		
		session["unread_message_count"]
	end
end

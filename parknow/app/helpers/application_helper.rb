module ApplicationHelper
	def invite_url token
		new_registration_path(invite_token:token)
	end
end

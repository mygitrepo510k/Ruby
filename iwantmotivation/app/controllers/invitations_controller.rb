class User::InvitationsController < Devise::InvitationsController
	def new
		@friend = User.find(params[:format])
		super
	end
	def update
		if User.accept_invitation!(user_params)
			sign_in(params[:user])
			redirect_to root_path, :notice => t('Invitation Accepted')
		else
			redirect_to root_path, :notice => t('Invitation Not Accepted')
		end
		#if this
		#	redirect_to root_path
		#else
		#	super
		#end
	end
end
class StoresController < InheritedResources::Base
	before_filter :authenticate_user!, :check_admin

	private
		def check_admin
			if current_user.roles.last.name != "admin"
        redirect_to :back
      end
		end
end

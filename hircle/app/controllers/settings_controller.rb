class SettingsController < ApplicationController

	def company_setting
		@user = current_user
		if current_user.company_id.nil?
			@company = Company.new
		else
			@company = Company.find(current_user.company_id)
		end
    # render :layout => 'settings'
	end

	def update_company_setting 

	if !params[:company][:name].empty?
		@company = Company.find_or_create_by_name(params[:company])
		puts "================#{@company.id}=========="
		current_user.update_attribute(:company_id, @company.id)
		
	end
	if !params[:user][:password].empty?

		if params[:user][:password] != params[:user][:password_confirmation]
			puts "---------------------------not -changed------------------------"	
     flash[:notice] = 'Password and Password confirmation does not match' 
  	else
    	current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      current_user.save!
    	puts "----------------------------changed------------------------"	
    	flash[:notice] = 'Password updated'
    end
	end
		redirect_to company_setting_path ,:notice => 'Company Setting Updated'
	end

end

class HomeController < ApplicationController
	protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  def index
  end


  # Parameters
		# email AND password (bcrypted),
		# device_id, 
		# device_type,
		# app_type
		# OR	customer_token
	def create_session		
		email 				= params[:email]
		psswd 				= params[:password]		
		token 				= params[:customer_token]		
		device_id 		= params[:device_id]
		device_type 	= params[:device_type]
		app_type 			= params[:app_type]
		
		if token.present?
			user = User.find_by_token(token)
			user = sign_in(:user, user)			
			render :json => {:success => resource.auth_token(device_id)}
		else
			user = User.find_for_database_authentication(:email => params[:email])
			if user.nil?
	      render :json => {faild:'No Such User'}, :status => 401
	    else	    	
	    	return render :json => {faild: "please input device_id and device_type, app_type"}, :status => 401 if device_id.blank? or device_type.blank? or app_type.blank?
	      if user.valid_password?( psswd )
	      	device = user.auth_tokens.where(device_id:device_id,app_type:app_type,device_type:device_type).first
	      	if device.present?
	      		sign_in( :user, user )
	      		render :json => {success: device.token}
	      	else
	      		render :json => {faild: "create new application user"}
	      	end	      	
	      else
	      	render :json => {faild: psswd}, :status => 401
	      end
	    end
		end    
	end

	#Parameters
		#email: 			String *required
		#password: 		String *required
		#device_id: 	String *required
		#device_type: String *required
		#app_type: 		String *required

	# def create_user
	# 	email     	= params[:email]
	# 	password  	= params[:password]
	# 	device_id 	= params[:device_id]
	# 	device_type = params[:device_type]
	# 	app_type 		= params[:app_type]
	# 	return render :json => {faild: "please input device_id and device_type, app_type"}, :status => 401 if device_id.blank? or device_type.blank? or app_type.blank?
		
	# 	user = User.where(email:email).first
	# 	if user.present?
	# 		device = user.auth_tokens.where(device_id:device_id,app_type:app_type,device_type:device_type)
	# 		if device.present?
	# 			render :json => {faild: 'This account was already registered'}, :status => 401
	# 		else
	# 			device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:app_type,device_type:device_type)
	# 			sign_in( :user, user )
	# 	    render :json => {:success => device.token}
	# 		end
	# 	else
	# 		user = User.new(email:email, password:password, password_confirmation:password)
	# 		if user.save
	# 			device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:app_type,device_type:device_type)
	# 			sign_in( :user, user )
	# 	    render :json => {:success => device.token}
	# 		else
	# 			render :json => {faild: user.errors.messages}, :status => 401
	# 		end
	# 	end		
	# end



	# #Parameters
	# 	#email: 			String *required
	# 	#password: 		String *required
	# 	#name:        String *required
	# 	#device_id: 	String *required
	# 	#device_type: String *required

	# def create_customer
	# 	email     	= params[:email]
	# 	password  	= params[:password]
	# 	name 				= params[:name]
	# 	device_id 	= params[:device_id]
	# 	device_type = params[:device_type]
	# 	app_type 		= params[:app_type]
	# 	return render :json => {faild: "please input device_id and device_type, app_type"}, :status => 401 if device_id.blank? or device_type.blank? or app_type.blank?
		
	# 	user = User.where(email:email).first
	# 	if user.present?
	# 		device = user.auth_tokens.where(device_id:device_id,app_type:app_type,device_type:device_type)
	# 		if device.present?
	# 			render :json => {faild: 'This account was already registered'}, :status => 401
	# 		else
	# 			device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[2],device_type:device_type)
	# 			sign_in( :user, user )
	# 	    render :json => {:success => device.token}
	# 		end
	# 	else
	# 		user = User.new(email:email, password:password, password_confirmation:password)
	# 		if user.save
	# 			device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[2],device_type:device_type)
	# 			sign_in( :user, user )
	# 	    render :json => {:success => device.token}
	# 		else
	# 			render :json => {faild: user.errors.messages}, :status => 401
	# 		end
	# 	end		
	# end

	# #parameters
	# 	# auth_token
	# 	# email
	# 	# password
	# def token_update
	# 	resource = User.find_by_token(params[:auth_token])
	# 	if resource.nil?
	# 		render :json => {faild:'No Such User'}, :status => 401
	# 	else
	# 		sign_out(resource)
	# 		render :json => {:success => 'sign out'}, :status => 200
	# 	end
	# end

	# Parameters
		# token
	def delete_session
		resource = User.find_by_token(params[:token])
		if resource.nil?
			render :json => {faild:'No Such User'}, :status => 401
		else
			sign_out(resource)
			render :json => {:success => 'sign out'}, :status => 200
		end
	end
end

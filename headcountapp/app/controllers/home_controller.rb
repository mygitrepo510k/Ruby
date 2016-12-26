class HomeController < ApplicationController
  
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  def index
  end


  def create_session
    email    = params[:email]
    password = params[:password]
    dev_id   = params[:dev_id]
    platform = params[:platform]

    resource = User.find_for_database_authentication( :email => email )
    if resource.nil?
      render :json => {faild:'No Such User'}, :status => 401
    else      
      if resource.valid_password?( password )
        device = resource.devices.where( dev_id:dev_id ).first
        if device.blank?
          device = resource.devices.build( dev_id:dev_id, platform:platform )
          device.save
        end
        user = sign_in( :user, resource )
        user_info={id:resource.id.to_s, user_name:resource.user_name,email:resource.email,token:resource.user_auth_id, auth_id:resource.authentication_token,social:resource.from_social, state:resource.sign_in_count > 1 ? 'older' : 'new'}
        render :json => {:success => user_info}
        else
          render :json => {faild: params[:password]}, :status => 401
        end
      end
   end

   def delete_session
    if params[:email].present?
        resource = User.find_for_database_authentication(:email => params[:email])
    elsif params[:user_id].present?
      resource = User.find(params[:user_id])
    end
    
    if resource.nil?
       render :json => {faild:'No Such User'}, :status => 401
    else         
    sign_out(resource)
       render :json => {:success => 'sign out'}
    end
  end
  
  # Destroy account API
  # POST: /api/v1/accounts/destroy
  # parameters:
  #   token:      String *required
  # results: 
  #   return success string
  def destroy
    user   = User.find_by_token params[:token]
    if user.present?      
      if user.destroy
        sign_out(resource)
        render :json => {:success => 'deleted account'}        
      else
        render :json => {:failure => "cannot delete this user"}  
      end
    else
      render :json => {:failure => "cannot find user"}
    end
  end


  # confirm API
  # POST: /api/v1/accounts/confirm_account
  # parameters:
  #    confirm_token:         String *required
  #    dev_id:                String *required
  # results:
  #    surccess string
  def confirm_account
    device = Device.where(dev_id:params[:dev_id])
    if device.present?
      user = device.user
      if user.confirmed_value == params[:confirmed_value]
        user.update_attribute(:confirmed_value,params[:confirmed_value])
        user = sign_in( :user, user )
        user_info={id:resource.id.to_s, user_name:resource.user_name,email:resource.email,token:resource.user_auth_id, auth_id:resource.authentication_token,social:resource.from_social, state:resource.sign_in_count > 1 ? 'older' : 'new'}
        render :json => {:success => user_info}
      else
        render :json => {faild:'no such verification code'}, :status => 401  
      end      
    else
      render :json => {faild:'cannot find this device'}, :status => 401
    end
  end




  def create_account
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    if User.where(email:params[:email]).first.present?      
      render json:{failure: 'This email already exist. Please try another email'} and return 
    end
    o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    pswd = (0...12).map{ o[rand(o.length)] }.join        
    user = User.new(email:params[:email], password:pswd, first_name:params[:name])
    if user.save
       user = sign_in(:user, user)
    UserMailer.welcome(user).deliver      
       render json: {:success => user.authentication_token}
    else
       render json: {:failure => 'failure not created'}
    end

  end

  def social_sign_in
    if params[:token].present?
      email        = params[:email].downcase    if params[:email].present?
      from_social  = params[:social].downcase   if params[:social].present?
      dev_id       = params[:dev_id]
      platform     = params[:platform]
      token        = params[:token]
      password     = params[:token][0..10]
      user_name    = params[:user_name]
      phone        = params[:phone]
      interest     = params[:interest]
      location     = params[:location]
      country_code = params[:country_code]

      user = User.any_of({:email=>email},{:user_auth_id => token}).first
      if user.present?        
        if dev_id.present?
          device = Device.where(dev_id:dev_id).first
          if device.blank?
            device = user.devices.build(dev_id:dev_id, platform:platform)
            device.save
          end
        end

        if sign_in(:user, user)
          user_info={id:user.id.to_s,user_name:user.user_name,email:user.email,token:user.user_auth_id, auth_id:user.authentication_token,social:user.from_social, avatar:user.avatar_url, state:'older', phone:user.phone}
          render json: {:success => user_info}
        else
          render json: {:failure => 'cannot login'}
        end
      else
          user = User.new(
              email:email,
              user_auth_id:token,
              password:password,
              user_name:user_name,
              from_social:from_social,
              country_code:country_code,
              phone:phone)
        if user.save
          if dev_id.present?
            device = Device.where(dev_id:dev_id).first
            if device.blank?
              device = user.devices.build(dev_id:dev_id, platform:platform)
              device.save
            end
          end
          
          if sign_in(:user, user)
            user_info={id:user.id.to_s, user_name:user.user_name,email:user.email,token:user.user_auth_id, auth_id:user.authentication_token,social:user.from_social, state:'new'}
            render json: {:success => user_info}
          else
            render json: {:failure => 'cannot login'}
          end
        else
          render :json => {:failure => user.errors.messages}
        end
      end
    end
  end

   def create
    email        = params[:email].downcase    if params[:email].present?
    from_social  = params[:social].downcase   if params[:social].present?
    dev_id       = params[:dev_id]
    platform     = params[:platform]    
    user_name    = params[:user_name]
    phone        = params[:phone]
    interest     = params[:interest]
    location     = params[:location]
    country_code = params[:country_code]
    
    if User.where(email:email).first.present?
      render json:{failure: 'This email already exists. Please try another email'} and return 
    end
    user = User.new(email:email, password:params[:password], user_name:user_name, location:location, country_code:country_code, interest:interest, from_social:from_social)
    if user.save
      device = user.devices.build(dev_id:dev_id, platform:platform)
      device.save
       if sign_in(:user, user)
        user_info={id:user.id.to_s, user_name:user.user_name,email:user.email,token:user.user_auth_id, auth_id:user.authentication_token,social:user.from_social}
        render :json => {:success => user_info}
      else
        render json: {:failure => 'cannot login'}
      end        
    else
      render :json => {:failure => user.errors.messages}
    end
  end

end

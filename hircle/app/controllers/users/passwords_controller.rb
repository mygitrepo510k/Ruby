class Users::PasswordsController <  ApplicationController
  
  def update
    if !params[:user][:current_password].nil? and !params[:user][:password].nil? and !params[:user][:password_confirmation].nil? 
           
      if current_user.update_attributes(params[:user])
        @user = current_user
      # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true        
      else
        @user = nil                    
      end
      
      redirect_to "/user_settings"
    end    
  end
end
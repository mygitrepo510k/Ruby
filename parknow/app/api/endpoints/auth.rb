module Endpoints
  class Auth < Grape::API

    resource :auth do

      # Customer API test
      # /api/v1/counts/ping
      # results  'gwangming'
      get :ping do        
        { :success => 'auth endpoints' }
      end
      
      # POST /auth/forgot_password
      # Parameters
        # email
      # Returns
        # HTTP 200 if email sent or user not found
        # HTTP 400 if server error occurs
      post :forgot_password do
        user = User.where(email:params[:email]).first
        if user.present?
          UserMailer.forgot_password(user).deliver
          {success: 'Email was sent successfully'}
        else
          {:failure => 'Cannot find this email'}
        end
      end

      # POST /auth/update
        # Parameters
          # auth_token:       String *required
          # email:            String
          # password:         String
          # name:             String
        # Returns
          # success string
      post :update do
        name        = params[:name]
        email       = params[:email]
        password    = params[:password]        
        author      = AuthToken.find_by_token(params[:auth_token])        
        if author.present?
          user      = author.user          
          if email.present?
            user.update_attribute(:email,email) if user.email != email and !User.exists?(email:email)
          elsif password.present?
            user.password = password
            user.password_confirmation = password
            user.save
          end
          
          if author.is_customer?
            customer = author.customer
            if customer.present?
              customer.update_attribute(:name,name)
            else
              {success: "Cannot find customer"}    
            end
          elsif author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              vendor.update_attribute(:name,name)
            else
              {success: "Cannot find vendor"}    
            end            
          elsif author.is_vendor_user?
            vendor_user = author.vendor_user
            if vendor_user.present?
              vendor_user.update_attribute(:name,name)
            else
              {success: "Cannot find vendor_user"}
            end
          end
          user.update_auth_tokens          
          {success: AuthToken.find(author.id).token}
        else
          {success: "Cannot find auth_token"}
        end

      end


      # POST /auth/enable_application
      # Parameters
        # auth_token
      post :enable_application do
        
      end

    end    
  end
end
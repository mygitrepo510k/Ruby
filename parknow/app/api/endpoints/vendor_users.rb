module Endpoints
  class VendorUsers < Grape::API

    resource :vendor_users do

      # VendorUsers API test
      # /api/v1/vendor_users/ping
      get :ping do
        { :success => 'vendors endpoints' }
      end      
      
      get :/ do
      end

      # Create vendor_user
      # POST /vendor_users/
      # Parameters
      #   email:            *required
      #   password:         *required
      #   name:             *required
      #   device_id:        *required
      #   device_type:      *required
      # Returns
      #   success: token
      post :/ do
        email       = params[:email]
        password    = params[:password]
        name        = params[:name]
        device_id   = params[:device_id]
        device_type = params[:device_type]

        return {faild: "please input device_id and device_type, app_type"} if device_id.blank? or device_type.blank?
    
        user = User.where(email:email).first
        if user.present?
          vendor_user = user.vendor_user
          device      = user.auth_tokens.where(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[1],device_type:device_type)
          if vendor_user.present?
            {faild: 'This account was already registered'}
          else
            vendor_user = user.create_vendor_user(name:name)
            if device.present?
              {faild: 'This device is using by other application'}
            else
              device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[1],device_type:device_type)
              {:success => device.token}
            end  
          end          
        else
          user = User.new(email:email, password:password, password_confirmation:password)
          if user.save
            vendor_user = user.create_vendor_user(name:name)
            device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[1],device_type:device_type)
            {:success => device.token}
          else
            {faild: user.errors.messages}
          end
        end   
      end

      # Update vendor_user
      # PUT /vendor_users/
      # Parameters
      #   auth_token:       String      *required
      #   name:             String      optional
      #   device_id:        String      *required
      #   device_type:      String      *required
      # Returns
      #   success: token
      put :/ do
        name        = params[:name]
        device_id   = params[:device_id]
        device_type = params[:device_type]

        author = AuthToken.find_by_token(params[:auth_token])
        
        if author.present?
          if author.is_vendor_user?
            if author.update_attributes(device_id:device_id, device_type:device_type)
              author.update_token
            else
              {faild: "Cannot update your device_id and device_type"}
            end
            if name.present?
              vendor_user = author.vendor_user
              vendor_user.update_attribute(:name, name) if vendor_user.present?
            end
            {success: author.token}
          else
            {faild: 'You are not a vendor user'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end


      # Get Service Request by ID
      # GET: /vendor_users/service_request
      # Parameters:
      #   auth_token:       String      *required
      #   request_id:       String      *required
      # Returns:
      #   success: JSON object
      get :service_request do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor_user?
            request = ServiceRequest.where(id:params[:request_id]).first
            if request.present?
              {success: {id:request.id,curstomer_id:request.customer_id,vehicle_id:request.vehicle_id,latitude:request.latitude,longitude:request.longitude,expiry:request.expiry,client_guid:request.client_guid}}
            else
              {faild: 'Cannot find request'}
            end
          else
            {faild: 'You are not a vendor user'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Get a list of non-expired service requests near my registered vendor location.
      # GET: /vendor_users/service_request_list
      # Parameters:
      #   auth_token:       String      *required
      # Returns:
      #   success: JSON object

      get :service_request_list do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor_user?
            vendor_user = author.vendor_user
            if vendor_user.present?
              vendor = vendor_user.vendor
              if vendor.present?
                #location = [vendor.latitude,vendor.longitude]
                requests = ServiceRequest.non_expired.near(vendor.location,10)
                list = requests.map{|r| {id:r.id,customer_id:r.customer_id,vehicle_id:r.vehicle_id,latitude:r.latitude,longitude:r.longitude,expiry:r.expiry,client_guid:r.client_guid}}
                {success: list}
              else
                {faild: 'Cannot find vendor'}
              end              
            else
              {faild: 'Cannot find vendor user'}
            end            
          else
            {faild: 'You are not a vendor user'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end





    end    
  end
end
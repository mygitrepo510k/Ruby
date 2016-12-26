module Endpoints
  class Vendors < Grape::API

    resource :vendors do

      # Vendors API test
      # /api/v1/vendors/ping
      get :ping do
        { :success => 'vendors endpoints' }
      end      
        
      # Get vendor info
      # GET /vendors/
      # Parameters
      #   auth_token:      String *required
      # Returns
      #   
      get :/ do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              {success: {id:vendor.id,name:vendor.name,description:vendor.description,latitude:vendor.latitude,longitude:vendor.longitude,email:vendor.user.email}}
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Create vendor
      # POST /vendors/
      # Parameters
      #   email:            String      *required
      #   password:         String      *required
      #   name:             String      *required
      #   device_id:        String      *required
      #   device_type:      String      *required
      #   latitude:         String      optional
      #   longitude:        String      optional
      #   description:      String      optional
      # Returns
        # success: token
      post :/ do
        email       = params[:email]
        password    = params[:password]
        name        = params[:name]
        device_id   = params[:device_id]
        device_type = params[:device_type]
        latitude    = params[:latitude]    
        longitude   = params[:longitude]
        description = params[:description]

        return {faild: "please input device_id and device_type, app_type"} if device_id.blank? or device_type.blank?
    
        user = User.where(email:email).first
        if user.present?
          vendor = user.vendor
          device = user.auth_tokens.where(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[0],device_type:device_type)
          if vendor.present?
            {faild: 'This account was already registered'}
          else
            vendor = user.create_vendor(name:name,latitude:latitude,longitude:longitude,description:description)
            if device.present?
              {faild: 'This device is using by other application'}
            else
              device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[0],device_type:device_type)
              {:success => device.token}
            end  
          end          
        else
          user = User.new(email:email, password:password, password_confirmation:password)
          if user.save
            vendor = user.create_vendor(name:name,latitude:latitude,longitude:longitude,description:description)
            device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[0],device_type:device_type)
            {:success => device.token}
          else
            {faild: user.errors.messages}
          end
        end   
      end

      # Update vendor
      # PUT /vendors/
      # Parameters
      #   auth_token:       String *required
      #   name:             String *required
      #   latitude:         String *required
      #   longitude:        String *required
      #   description:      String *required

      # Returns
      #   success: string
      put :/ do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              vendor.update_attributes(name:params[:name],latitude:params[:latitude],longitude:params[:longitude],description:params[:description])
              {success: "Updated vendor"}
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Vendor's invite list
      # POST /vendors/invite
      # Parameters
      #   auth_token:       String *required
      # Returns
      #   success: string
      get :invite do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              invitations = Invitation.where(sender_id:vendor.user.id,state:Invitation::STATE[0]) #Invitation.where(sender_id:vendor.user.id).group("recipient_email").select("recipient_email")
              {success:invitations.map{|inv| {id:inv.id,recipient_email:inv.recipient_email,invite_token:inv.token}}}
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end


      # Invite vendor user
      # POST /vendors/invite
      # Parameters
      #   auth_token:       String *required
      #   email:            String *required
      # Returns
      #   success: string
      post :invite do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              invitation = Invitation.new(sender_id:author.user.id,vendor_id:vendor.id, recipient_email:params[:email])
              invitation.sender = author.user
              if invitation.save
                UserMailer.invitation(invitation).deliver
                {success: "Sent invitation mail"}
              else
                {faild: invitation.errors.messages}
              end
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end


      # Create vendor terms
      # POST: /vendors/terms
      # Parameters
      #   auth_token:           String      *required 
      #   hourly_rate:          String      optional
      #   max_hourly_hours:     String      optional
      #   flat_rate:            String      optional
      #   max_flat_hours:       String      optional
      # Returns
      #   Success string
      post :terms do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor            
            hourly_rate       = params[:hourly_rate]
            max_hourly_hours  = params[:max_hourly_hours]
            flat_rate         = params[:flat_rate]
            max_flat_hours    = params[:max_flat_hours]
            if vendor.present?
              vendor_term = vendor.vendor_terms.build(hourly_rate:hourly_rate,max_hourly_hours:max_hourly_hours,flat_rate:flat_rate,max_flat_hours:max_flat_hours)
              if vendor_term.save
                {success: "Created successfully"}
              else
                {faild: vendor_term.errors.messages}
              end
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Update vendor terms
      # PUT: /vendors/terms
      # Parameters
      #   auth_token:           String      *required 
      #   vendor_terms_id:      String      *required
      #   hourly_rate:          String      optional
      #   max_hourly_hours:     String      optional
      #   flat_rate:            String      optional
      #   max_flat_hours:       String      optional
      # Returns
      #   Success string
      put :terms do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor            
            hourly_rate       = params[:hourly_rate]
            max_hourly_hours  = params[:max_hourly_hours]
            flat_rate         = params[:flat_rate]
            max_flat_hours    = params[:max_flat_hours]
            if vendor.present?
              vendor_term = vendor.vendor_terms.where(id:params[:vendor_terms_id]).first
              if vendor_term.present?
                if vendor_term.update_attributes(hourly_rate:hourly_rate,max_hourly_hours:max_hourly_hours,flat_rate:flat_rate,max_flat_hours:max_flat_hours)
                  {success: "Updated successfully"}
                else
                  {faild: vendor_term.errors.messages}
                end
              else
                {faild: "Cannot find vendor terms"}
              end
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end


      # Revoke vendor user from this vendor
      # POST: /vendors/revoke
      # Parameters
      #   auth_token:           String      *required
      #   vendor_user_id:       String      *required
      # Returns
      #   success or failure string

      post :revoke do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              vendor_user = vendor.vendor_users.where(id:params[:vendor_user_id]).first
              if vendor_user.present?
                vendor_user.update_attribute(:sender_id,nil)
                {success: "revoked vendor user"}
              else
                {faild: "Cannot find vendor user"}  
              end
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Revoke invitation from this vendor
      # POST: /vendors/revoke
      # Parameters
      #   auth_token:           String      *required
      #   invitation_token:     String      *required
      # Returns
      #   success or failure string
      # 
      post :invitation_revoke do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor?
            vendor = author.vendor
            if vendor.present?
              invitation = Invitation.pending_invitations.where(token:params[:invitation_token]).first
              if invitation.present?
                invitation.update_attribute(:state, Invitation::STATE[2])
                {success: "Revoked invitation"}
              else
                {faild: "Cannot find invitation"}
              end
            else
              {faild: "Cannot find vendor"}
            end
          else
            {faild: 'You are not a vendor'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end


    end    
  end
end
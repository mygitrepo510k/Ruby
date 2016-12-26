module Endpoints
  class Customers < Grape::API

    resource :customers do

      # Customer API test
      # /api/v1/customers/ping
      # results  success string
      get :ping do
        { :success => 'customer endpoints' }
      end      
      
      # Get customer information
      # GET /customers/
      # Parameters
        # auth_token
      # Returns
        # JSON Object
      get :/ do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_customer? and author.customer.present?
            customer = author.customer
            if customer.present?
              vehicles = customer.vehicles.map{|v| {vehicle_id:v.id.to_s,license_plate:v.license_plate,make:v.make,model:v.model,color:v.color}}            
              requests = customer.service_requests.map{|r| {id:r.id,vehicle_id:r.vehicle_id,latitude:r.latitude,longitude:r.longitude,expiry:r.expiry,client_guid:r.client_guid,offers:r.service_offers.map{|o| {id:o.id,vendor_id:o.vendor_id,vendor_terms_id:o.vendor_terms_id,state:o.state}}}}

              {success: {id:customer.id.to_s,email:customer.user.email,name:customer.name,balance:customer.balance,available_balance:customer.available_balance,vehicles:vehicles,requests:requests}}
            else
              {faild: "Cannot find customer"}
            end
          else
            {faild: 'You are not a customer'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Create customer
      # POST /customers/
      # Parameters
        # email:            *required
        # password:         *required
        # name:             *required
        # device_id:        *required
        # device_type:      *required
      # Returns
        # success: token
      post :/ do
        email       = params[:email]
        password    = params[:password]
        name        = params[:name]
        device_id   = params[:device_id]
        device_type = params[:device_type]

        return {faild: "please input device_id and device_type, app_type"} if device_id.blank? or device_type.blank?
    
        user = User.where(email:email).first
        if user.present?
          customer = user.customer
          device = user.auth_tokens.where(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[2],device_type:device_type)
          if customer.present?
            {faild: 'This account was already registered'}
          else
            customer = user.create_customer(name:name)
            if device.present?
              {faild: 'This device is using by other application'}
            else
              device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[2],device_type:device_type)
              {:success => device.token}
            end  
          end          
        else
          user = User.new(email:email, password:password, password_confirmation:password)
          if user.save
            customer = user.create_customer(name:name)
            device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:AuthToken::APP_TYPE_NAME[2],device_type:device_type)
            {:success => device.token}
          else
            {faild: user.errors.messages}
          end
        end   
      end

      # Update customer
      # POST /customers/
      # Parameters
        # customer_name
        # auth_token
      #Returns
        # success string
      put :/ do
        name = params[:customer_name]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          user = author.user
          customer = user.customer
          if customer.present?            
            if customer.update_attribute(:name,name)
              {success: "Updated customer"}
            else
              {faild: customer.errors.messages}
            end
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Get customer's vehicle list
      # GET /customers/vehicles
      # Parameters
        # auth_token
      # Returns
        # JSON Object
      get :vehicles do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer = author.customer
          if customer.present?
            vehicles = customer.vehicles.map{|v| {vehicle_id:v.id.to_s,license_plate:v.license_plate,make:v.make,model:v.model,color:v.color}}
            {success: vehicles}            
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Create vehicle
      # POST /customers/vehicle
      # Parameters
        # auth_token
        # license_plate
        # make
        # model
        # color
      post :vehicle do
        license_plate = params[:license_plate]
        make          = params[:make]
        model         = params[:model]
        color         = params[:color]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer = author.customer
          if customer.present?
            vehicle = customer.vehicles.build(license_plate:license_plate,make:make,model:model,color:color)
            if vehicle.save
              {success: "Created vehicle"}
            else
              {faild: vehicle.errors.messages}
            end
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Edit vehicle
      # PUT /customers/vehicle
      # Parameters
        # auth_token
        # vehicle_id
        # license_plate
        # make
        # model
        # color
      put :vehicle do
        license_plate = params[:license_plate]
        make          = params[:make]
        model         = params[:model]
        color         = params[:color]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer = author.customer
          if customer.present?
            vehicle = customer.vehicles.where(id:params[:vehicle_id]).first
            if vehicle.present?
              vehicle.update_attributes(license_plate:license_plate,make:make,model:model,color:color)
              {success: "Updated vehicle"}
            else
              {faild: "Cannot find vehicle"}
            end
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end     
      end

      # Delete vehicle
      # Delete /customers/vehicle
      # Parameters
        # auth_token
        # vehicle_id
      delete :vehicle do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer = author.customer
          if customer.present?
            vehicle = customer.vehicles.where(id:params[:vehicle_id]).first
            if vehicle.present?
              vehicle.destroy
              {success: "Deleted vehicle"}
            else
              {faild: "Cannot find vehicle"}
            end
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end     
      end

      # Change device token
      # PUT /customers/change_device_token
      # Parameters
      #   auth_token
      #   device_id
      #   device_type
      # Returns
      #   success: auth_token

      put :change_device_token do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer      = author.customer
          device_id     = params[:device_id]
          device_type   = params[:device_type]
          if customer.present?
            author.update_attributes(device_id:device_id,device_type:device_type)
            {success: author.update_token}
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

      # Get PaymentTransactions
      # GET: /customers/payment_transactions
      # Parameters
      #   auth_token
      #   device_id
      #   device_type
      # Returns
      #   JSON Object
      get :payment_transactions do
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present? and author.is_customer?
          customer      = author.customer
          if customer.present?
            transactions = PaymentTransactions.senders_customers(sender_id:customer.id)
            {success: transactions.map{|t| {id:t.id,sender_type:t.sender_type,sender_id:t.sender_id,receiver_type:t.receiver_type,receiver_id:t.receiver_id,debit:t.debit,credit:t.credit,transaction_foreign_id:t.transaction_foreign_id}}}
          else
            {faild: "Cannot find customer"}
          end          
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end

    end    
  end
end
module Endpoints
  class ServiceRequests < Grape::API

    resource :service_requests do

      # Customer API test
      # /api/v1/service_requests/ping
      get :ping do
        { :success => 'service_requests endpoints' }
      end      
      
      # POST /service_requests/
      # Parameters
        # auth_token
        # vehicle_id
        # latitude
        # longitude
        # client_guid
      # Returns
        # success string
      post :/ do        
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          vehicle_id    = params[:vehicle_id]
          latitude      = params[:latitude]
          longitude     = params[:longitude]
          client_guid   = params[:client_guid]

          if author.is_customer?
            customer = author.customer
            if customer.present?
              expiry = DateTime.now + 3.minutes
              service_request = customer.service_requests.build(vehicle_id:vehicle_id,latitude:latitude,longitude:longitude,expiry:expiry,client_guid:client_guid)
              if service_request.save
                {success: "created service request"}
              else
                {faild: service_request.errors.messages}  
              end

            else
              {faild: 'Cannot find customer'}  
            end
          else
            {faild: 'You are not a customer'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end
      end
      
      # GET /service_requests/?request_id
      # Parameters
        # auth_token
        # request_id
      # Returns
        # JSON object
      get :/ do
        request_id = params[:request_id]

        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_customer? and author.customer.present?
            customer = author.customer
            request   = customer.service_requests.where(id:request_id).first

            if request.present?
              offers = request.service_offers.map{|offer| {id:offer.id.to_s,vendor_id:offer.vendor_id,vendor_terms_id:offer.vendor_terms_id,state:offer.state}}
              {success: {id:request.id, ehicle_id:request.vehicle_id,latitude:request.latitude,longitude:request.longitude,expiry:request.expiry,client_guid:request.client_guid,offers:offers}}
            else
              {faild: "cannot find request"}
            end           
            
          else
            {faild: 'You are not a customer'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end        
      end

      # GET /service_requests/get_by_geolocation
      # Parameters
        # auth_token
        # latitude, longitude
      # Returns
        # JSON object
      get :get_by_geolocation do
        latitude   = params[:latitude]
        longitude  = params[:longitude]

        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_customer? and author.customer.present?
            customer = author.customer
            requests  = ServiceRequest.near([latitude,longitude], 1)
            if requests.present?
              request_list = []
              requests.each do |request|
                offers = request.service_offers.map{|offer| {id:offer.id.to_s,vendor_id:offer.vendor_id,vendor_terms_id:offer.vendor_terms_id,state:offer.state}}
                request_list << {id:request.id, ehicle_id:request.vehicle_id,latitude:request.latitude,longitude:request.longitude,expiry:request.expiry,client_guid:request.client_guid,offers:offers}
              end              
              {success: request_list}
            else
              {faild: "cannot find request"}
            end            
          else
            {faild: 'You are not a customer'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end        
      end


      # Accept request
      # POST /service_requests/accept
      #   Parameters
      #     auth_token:   String        *required
      #     request_id:   Integer       *required
      #   Returns
      #     JSON Object
      post :accept do
        request_id = params[:request_id]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_vendor_user? and author.vendor_user.present?
            vendor_user = author.vendor_user
            request  = customer.service_requests.where(id:request_id).first
            if request.present?
              vendor          = vendor_user.vendor
              vendor_terms    = vendor.enabled_temrs.last 
              offer = request.service_offers.build(vendor_id:vendor.id,vendor_terms_id:vendor_terms.id,state:ServiceOffer::STATE[1])
              if offer.save
                {success: "Accepted service requests"}
              else
                {faild: offer.errors.messages}
              end

            else
              {faild: "Cannot find request"}
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
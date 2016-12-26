module Endpoints
  class ServiceOffers < Grape::API

    resource :service_offers do

      # Customer API test
      # /api/v1/service_requests/ping
      get :ping do
        { :success => 'service_offers endpoints' }
      end

      # Accept offer
      # POST /service_offers/accept
      #   Parameters
      #     auth_token
      #     offer_id
      #   Returns
      
      post :accept do
        offer_id = params[:offer_id]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_customer? and author.customer.present?
            offer = customer.service_offers.where(id:offer_id)
            if offer.present?              
              contract = offer.build_service_contract(parked_at:DateTime.now, service_request_id:offer.service_request_id, state:ServiceContract::STATE[0])
              if contract.save
                request = offer.service_request                
                request.service_offers.each do |offer|
                  offer.update_attribute(:state,ServiceOffer::state[2])
                end
                offer.update_attribute(:state,ServiceOffer::state[1])
              else
                {faild: contract.errors.messages}
              end
              {success: 'Cancelled contract'}
            else
              {faild: 'Cannot find service contract'}
            end
          else
            {faild: 'You are not a customer'}
          end
        else
          {faild: 'Cannot find this token, please login again'}
        end     
      end



    end    
  end
end
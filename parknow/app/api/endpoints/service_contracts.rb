module Endpoints
  class ServiceContracts < Grape::API

    resource :service_contracts do

      # Customer API test
      # /api/v1/service_requests/ping
      get :ping do
        { :success => 'service_contracts endpoints' }
      end

      # Cancle ServiceContract
      # POST: /service_contracts/cancel
      # Parameters
			#   auth_token:    String 		*required
			#   contract_id:   Integer    *required
			# Returns
			#   success string
      post :cancel do
      	contract_id = params[:contract_id]
        author = AuthToken.find_by_token(params[:auth_token])
        if author.present?
          if author.is_customer? and author.customer.present?
          	contract = customer.service_contracts.where(id:contract_id).first
          	if contract.present?
          		contract.update_attribute(:state,ServiceContract::STATE[2])
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
#require 'grape-swagger'
class API < Grape::API
  prefix 'api'
  version 'v1'
  format :json

  # load remaining API endpoints
  mount Endpoints::Auth  
  mount Endpoints::Customers
  mount Endpoints::VendorUsers
  mount Endpoints::Vendors
  mount Endpoints::ServiceRequests
  mount Endpoints::ServiceOffers
  mount Endpoints::ServiceContracts
  #add_swagger_documentation
end

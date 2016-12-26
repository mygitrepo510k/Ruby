module ParkNow
  class API < Grape::API
    prefix 'api'
    version 'v1'
    format :json

    get '/sample' do
      "GET request successful."
    end

    post '/sample' do
      "POST request successful."
    end

    put '/sample' do
      "PUT request successful."
    end

    delete '/sample' do
      "DELETE request successful."
    end

  end
end
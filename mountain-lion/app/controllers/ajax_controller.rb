require "net/http"
require "uri"
class AjaxController < ApplicationController

  def cities
    if params[:callback].present?
      callback = params[:callback]
      cities = City.where(country_code: params['country'].upcase).
                    where('lower(name) like ?',"#{params['name_startsWith'].downcase}%")
      render json: "#{callback}(#{cities.to_json(methods: :state_name)})"
    else
      render json: '{}'
    end
  end


  private
  def post_data(options)
    uri = URI.parse(URL)

    # Full control
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Post.new(uri.request_uri)
    req.set_form_data(options)

    http.request(req)
  end
end

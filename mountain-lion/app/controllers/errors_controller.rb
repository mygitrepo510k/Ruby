class ErrorsController < ApplicationController
  skip_filter :require_login

  def not_found
    flash[:error]= "The resource you are looking for is not there"
    redirect_to root_url
  end

  def something_wrong
    render file: Rails.root.join('app', 'assets', 'html', '500.html.erb'), layout: false
  end

end

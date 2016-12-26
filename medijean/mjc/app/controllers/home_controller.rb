# @author: Hammad Siddiqui

class HomeController < ApplicationController
  # The Home Page
  #
  # @route GET /
  # @wireframe https://projects.invisionapp.com/d/main#/console/381469/8245145/preview
  # @renders index.html.haml
  def index
    if user_signed_in?
      flash.keep
      redirect_to home_path_for(current_user)
    end
  end
end

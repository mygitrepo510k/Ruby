class SessionsController < ApplicationController
  def create
    uid = request.env['omniauth.auth'].uid
    user = User.where(uid: uid).first_or_create
    session[:user_id] = user.id
    redirect_to :root
  end

  def show
    @user = User.find_by_id(session[:user_id])
  end
end
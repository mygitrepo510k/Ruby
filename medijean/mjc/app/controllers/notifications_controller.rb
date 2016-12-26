class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  # This action renders all notifications of the user.
  def index
    @user_notifications = current_user.notifications.page(params[:page]).per(10)
  end

end

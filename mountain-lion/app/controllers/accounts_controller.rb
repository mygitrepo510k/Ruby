class AccountsController < ApplicationController
  before_action :check_logged_user
  def index
    @user = AccountSettings.new(current_user)
  end

  def update
    @user = AccountSettings.new(current_user, account_params)
    if @user.save
      flash.notice = "You have succesfully updated your profile!"
      redirect_to user_profile_path
    else
      render :index
    end
  end

  private
  def account_params
    params.require(:account_settings).permit(:password, :old_password, :password_confirmation, :receives_messages,
      :receives_flirts, :receives_matches, :receives_likes, :firstname, :lastname, :username, :date_of_birth, :gender,
      :country_code, :state_code, :city, :receives_new_users)
  end
end

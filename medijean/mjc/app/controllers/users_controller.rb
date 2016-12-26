class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_profile_update_required, :only => [:dashboard]

  respond_to :html

  # Represents the patient dashboard.
  def dashboard
    flash.keep
    redirect_to doctors_dashboard_path and return false if current_user.role?(:doctor)
    redirect_to prescriptions_path
  end
end
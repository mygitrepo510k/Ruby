class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :user_profile_update_required, :only => [:dashboard]

  before_filter :set_paper_trail_status
  before_filter :load_notifications_if_user_signin

  def set_paper_trail_status
    PaperTrail.enabled = current_admin_user.present?
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}" if Rails.env.development?
    if user_signed_in?
      redirect_to main_app.root_url, :alert => exception.message
    else
      redirect_to new_user_session_path, :notice => "Please sign in to continue"
    end
  end

  # Checks if the user which has logged in has completed his profile or not,
  # if the user has not completed his profile then it redirects to the complete profile page showing a flash message "Please complete your profile first"
  def user_profile_update_required
    if user_signed_in? and not current_user.profile_updated and not current_user.role?(:doctor)
      flash[:error] = t('patient_flow.complete_profile.update_required')
      redirect_to "/registrations/profile" and return false
    end
  end

  # Checks if the doctor which has logged in has completed his profile or not
  def doctor_profile_update_required
    if user_signed_in? and not current_user.profile_updated and current_user.role?(:doctor)
      flash[:error] = t('doctor_flow.complete_profile.update_required')
      redirect_to '/doctors/new' and return false
    end
  end

  # Determines the path to which the user needs to be redirected to after the sign in,
  # Currently it checks if the user is signing in for the first time, it then redirects the user to the complete profile page other wise to the user dashboard
  # @todo Add redirection rules for different roles.
  #  Code needs to be written in order to differentiate user by their roles and return a redirection link accordingly
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      users_dashboard_path
    else
      super
    end
  end

  # @return [String] dashboard path for current role
  def home_path_for(resource)
    case current_user.current_role.name
    when "patient"
      users_dashboard_path
    when "doctor"
      doctors_dashboard_path
    end
  end

  # This ensures that if the user is not signed in, deny his access to the resource and redirect user to the login page
  def user_required
    unless current_user
      flash[:error] = t('general.user_required')
      redirect_to new_user_session_path and return false
    end
  end

  def user_for_paper_trail
    admin_user_signed_in? ? current_admin_user : 'Unknown user'
  end

  def current_doctor
    current_user.try(:linked_doctor)
  end

  # @param [String] required role
  # redirects to back or to root_path if user doesn't have a required_role
  def redirect_unless_user_is(required_role)
    redirect_to (request.referer || root_path), flash: { erorr: t('general.no_access') } and return false unless current_user.role?(required_role)
  end

  protected
  # This  functions load notifications for the current sign-in user
  def load_notifications_if_user_signin
    if user_signed_in?
      @current_user_notifications = current_user.notifications.page(params[:page]).per(10)
    end
  end

end

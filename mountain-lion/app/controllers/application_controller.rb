class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_users_online, :production?, :admin_user, :current_user

  private
  def redirect_incomplete_profile
    if !current_user.required_user_fields_complete? && !session[:admin_id].present?
      redirect_to(mandatory_edit_profile_user_path(current_user), notice: I18n.t('controllers.sessions.create.success'))
    end
  end

  def current_users_online
    online_users
  end

  def check_logged_user
    unless user_present?
      session[:return_to_url] = request.url
      logout
      redirect_to(login_url, notice: "You must be logged in to see this page")
    end
  end

  def user_present?
    current_user.present? && current_user.is_a?(User) && !current_user.blocked
  end

  def production?
    Rails.env.production?
  end

  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    unless html_tag =~ /^<label/
      %{<div class="field_with_errors">#{html_tag}<div class="tooltip-validate fade right in" style="display: block;"><div class="tooltip-validate-arrow"></div><div class="tooltip-validate-inner"><label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div></div></div>}.html_safe
    else
      %{<div class="field_with_errors">#{html_tag}</div>}.html_safe
    end
  end

  def admin_user
    @admin_user ||= Admin.find(session[:admin_id]) if session[:admin_id].present?
  end
  def admin_user=(user)
    @admin_user = user
    session[:admin_id] = user.id
  end
end

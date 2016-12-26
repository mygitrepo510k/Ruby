module HomeHelper
  def resource_name
    :user
  end

  def resource
    @resource = session[:subscription] || User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end

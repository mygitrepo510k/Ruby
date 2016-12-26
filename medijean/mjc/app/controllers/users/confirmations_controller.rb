class Users::ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    return new_doctor_path if resource.role?(:doctor)
    return registrations_profile_path
  end

end
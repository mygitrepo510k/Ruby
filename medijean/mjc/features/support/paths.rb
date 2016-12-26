module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the homepage/
      root_path
    when /the log in page/
      new_user_session_path
    when /the patient dashboard/
      users_dashboard_path
    when /the doctor dashboard/
      doctors_dashboard_path
    when /the patient welcome page/
      registrations_welcome_path
    when /the patient profile page/
      registrations_profile_path
    when /find doctor page/
      registrations_find_doctor_path
    when /the prescriptions path/
      prescriptions_path
    when /the prescriptions upload page/
      prescriptions_upload_path
    when /the prescription review page/
      review_prescription_path(Prescription.last)
    when /prescription upload page/
      '/prescriptions/upload'
    when /the new order page/
      "/orders/new?prescription_id=#{Prescription.last.id}"
    when /the doctor profile page/
      new_doctor_path
    when /the doctors dashboard page/
      doctors_dashboard_path
    when /the registration doctor page/
      registrations_by_role_path(:doctor)
    when /the orders completed page/
      complete_orders_path
    when /the orders page/
      orders_path
    when /the notifications page/
      notifications_path
    when /the knowledge center page/
      knowledge_centre_path
    when /new order page/
      new_order_path
    when /the doctor registration page/
      registrations_by_role_path(role: 'doctor')
    when /new doctor page/
      new_doctor_path
    when /invitation confirmation page/
      invitation_confirmation_path(token: DoctorPatient.last.invitation_token)
    when /the settings profile/
      settings_profile_path
    when /the settings account/
      settings_account_path
    when /the settings payment/
      settings_payment_path
    when /the settings notifications/
      settings_notification_path
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)

class Users::InvitationRegistrationsController < ApplicationController

  def new
    @doctor_patient = DoctorPatient.find_by_invitation_token(params[:token])
    @user = if current_user
      @doctor_patient.update_attribute(:user_id, current_user.id)
      current_user
    else
      User.new(email: @doctor_patient.email)
    end
  end
end
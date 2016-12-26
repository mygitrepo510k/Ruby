class Doctors::ProfilesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource :profile

  def show
    @doctor_patient = DoctorPatient.find(params[:id])
    @profile        = @doctor_patient.active? ? @doctor_patient.user.profile : Profile.new
  end
end
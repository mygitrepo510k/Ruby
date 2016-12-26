class DoctorPatientsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  respond_to :html
  respond_to :js, only: [:new]

  def new
    @doctor_patient = DoctorPatient.new(doctor_id: current_doctor.id)
  end

  def create
    @doctor_patient = DoctorPatient.new(params[:doctor_patient])
    @doctor_patient.doctor_id = current_doctor.id
    if @doctor_patient.save
      redirect_to doctors_dashboard_path, flash: { notice: t('doctor_flow.patients.patient_added') }
    else
      redirect_to doctors_dashboard_path
    end
  end
end
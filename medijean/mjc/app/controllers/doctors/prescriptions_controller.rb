class Doctors::PrescriptionsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  respond_to :html

  def new
    @prescription = Prescription.new
  end

  def create
    @prescription = Prescription.build_from( params[:prescription].merge(doctor_id: current_doctor.id, doctor_patient_id: params[:doctor_patient_id]) )
    if @prescription.save
      redirect_to doctors_dashboard_path, flash: { notice: "Prescription created! Patient will be notified via email." }
    else
      respond_with(@prescription)
    end
  end

  def show
    @prescription = Prescription.find(params[:id])
  end
end

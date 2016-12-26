class DoctorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :extract_attributes, only: [:update, :create]
  before_filter :doctor_profile_update_required, only: [:dashboard]
  load_and_authorize_resource
  skip_load_resource only: [:edit, :create]
  skip_authorize_resource except: [:new, :update, :edit]

  respond_to :html
  respond_to :js, only: [:edit]

  # Search the doctors matching the search criteria in the params hash then responds the required json format.
  def search
    @doctors = Doctor.search params[:search]
    respond_to do |format|
      format.json {
          render :json => {
            :success => true,
            :records_found => @doctors.count,
            :data => {:doctors => @doctors.map{|doctor| {:first_name => doctor.first_name,:last_name => doctor.last_name} } }
          }
        }
      end
  end

  def claim_profile

  end

  def invite_patient
  end

  # Search the patients and responds to the json format.
  def search_patients
    @patients = User.search_patients params[:search]

    respond_to do |format|
      format.json {
        render :json => {
            :success => true,
            :records_found => @patients.count,
            :data => {:patients => @patients.map{|patient| {:first_name => patient.first_name,:last_name => patient.last_name} } }
          }
      }
    end
  end


  def index

  end

  # Represents the doctor dashboard.
  def dashboard
    @doctor_patients = DoctorPatient.where("doctor_id IS NULL OR doctor_id = ?", current_doctor.id).page(params[:page]).per(10)
  end

  # This is an action created for displaying the Pending Claim page to the doctors.
  def pending_claim
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.build_from(params[:doctor].merge(user_id: current_user.id))
    if @doctor.save
      current_user.update_attribute(:profile_updated, true)
      redirect_to doctors_dashboard_path, flash: { notice: t('doctor_flow.profile_update.thank_you', name: @doctor.last_name) }
    else
      render "#{params[:origin]=='settings' ? 'edit' : 'new'}"
    end
  end

  def edit
    if current_user.linked_doctor
      redirect_to(prescriptions_path, flash: { error: t('general.allowed_once') }) and return false
    end
    @found_doctor = Doctor.includes(:clinic => [:address]).not_registered.where(physician_id: params[:id]).first
  end

  def update
    clinic  = params[:doctor].delete(:clinic)
    address = clinic.delete(:address_attributes)
    @doctor = Doctor.find params[:id]
    @doctor.transaction do
      Doctor.find(params[:doctor][:id]).update_attribute(:user_id, current_user.id) if params[:doctor][:id] and current_user.linked_doctor.nil?
      @doctor.update_attributes(params[:doctor])
      @doctor.set_clinic(clinic)
      @doctor.clinic.set_address(address)
    end

    unless @doctor.errors.any? or @doctor.clinic.nil? or @doctor.clinic.address.nil?
      redirect_to settings_profile_path, flash: { notice: t("settings.profile.successfully_updated")} and return false if params[:origin] == "settings"
      redirect_to doctors_dashboard_path, flash: { notice: t('doctor_flow.profile_update.thank_you', name: @doctor.last_name) }
    else
      redirect_to settings_profile_path and return false if params[:origin] == "settings"
      @doctor = Doctor.includes(:clinic => [:address]).not_registered.where(physician_id: params[:doctor][:physician_id]).first || Doctor.new
      render 'edit'
    end
  end

  protected

  def extract_attributes
    params[:doctor].merge!({ phone: params.delete(:doctor_phone).values.join('-'), user_id: current_user.id })
    params[:doctor][:clinic].merge!({ phone: params.delete(:clinic_phone).values.join('-') })
  end
end
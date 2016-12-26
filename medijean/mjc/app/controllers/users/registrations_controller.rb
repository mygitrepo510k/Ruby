# Handles user registration
class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :sign_in_invited_user, only: [:complete_profile]
  before_filter :user_required, :only => [:find_doctor, :profile]
  before_filter :define_role, only: [:new, :create]

  # @note devise built in method over ridden
  def create
    build_resource sign_up_params

    found_invitation = DoctorPatient.where(email: resource.email).first if resource.email
    if found_invitation
      resource.skip_confirmation!
      found_invitation.generate_invitation! unless found_invitation.invitation_token
    end

    if resource.save
      resource.set_role(params[:role])
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource, found_invitation)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # Attempts to find a profile if exists, otherwise creates an empty record against the user for later updating the record.
  def profile
    @profile = current_user.profile
    #@health_card_numbers = @profile.health_card_number.nil? ? Array.new(4)  :   @profile.health_card_number.split('-')
    @phone = @profile.phone.nil? ? Array.new(3)  :   @profile.phone.split('-')
  end

  # Finds the user profile and updates the attributes from the params hash, the determine wether
  # to save the reason from the select menu or the dynamic textbox, saves the profile, updates the
  # profile updated boolean property in the user table to true, to indicate that the user has completed his profile and redirects to the find your doctor step.
  def complete_profile
    @phone = Array.new(3)
    @profile = current_user.profile
    @user = current_user
    phone = params[:profile][:phone].values.join("-")
    params[:profile][:phone]= phone
    @profile.update_attributes(params[:profile])
    # THIS CODE IS COMMENTED OUT, IT WILL BE NEEDED TO SAVE THE REASON DEPENDING ON THE SELECT BOX VALUE
    # if params[:reason] == "Other"
    #     reason_description = params[:reason_description]
    #   else
    #     reason_description = params[:reason]
    # end
    # @profile.reason_description = reason_description
    if @profile.save
      @user.profile_updated=true
      @user.save
      @doctor_patient.update_attribute(:health_card_number, @profile.health_card_number) if @doctor_patient
      # send an complete profile email to user
      respond_to do |format|
        format.html{ redirect_to after_successful_profile_complete_path_for(resource) }
        format.json {
          render :json => {
              :success => true
            }
        }
      end
      flash[:notice] = t('patient_flow.complete_profile.notice')
    else
      respond_to do |format|
        format.html { render :action => :profile }
        format.json {
          render :json => {
              :success => false
            }
        }
      end
    end
  end

  # This action renders the Patient view, Pateint user can find there doctor after login
  def find_doctor
  end

  # This action renders the view of Patient Welcome which is rendered when the patient logs in
  # for the very first time.
  def welcome
  end

  # Making sure that invited patient will be redirected to his special profile completion page
  # if no invitation_token found(meaning no prescription made by doctor)
  def after_sign_up_path_for(resource, found_invitation=nil)
    found_invitation ? invitation_confirmation_path(token: found_invitation.invitation_token) : after_sign_in_path_for(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    resource.role?(:doctor) ? registrations_by_role_path(role: 'doctor') : root_path
  end

  protected

  # In case user came to website using invitation_token - direct him to prescription assigned by doctor
  # in other cases - allow him to upload his own prescription
  def after_successful_profile_complete_path_for(resource)
    if @skip_prescription_review
      users_dashboard_path
    elsif @doctor_patient
      review_prescription_path(id: @doctor_patient.prescription.id)
    else
      prescriptions_upload_path
    end
  end

  # Makes sure that in case user is followed invitation_token User instance will be created and user will be signed_in
  def sign_in_invited_user
    @doctor_patient = DoctorPatient.invited.where(invitation_token: params[:token]).first if params[:token]
    if current_user.nil?
      user          = User.new(email: @doctor_patient.email, invitation_token: @doctor_patient.invitation_token)
      user.password = params[:user][:password]
      user.skip_confirmation!
      user.roles << Role.lookup(:patient)
      if user.save
        sign_in(user)
      end
    elsif @doctor_patient
      @skip_prescription_review = true
    end
  end

  def define_role
    @role = Role::PUBLIC.include?(params[:role]) ? params[:role] : Role::DEFAULT
  end
end

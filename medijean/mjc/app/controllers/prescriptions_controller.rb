class PrescriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_constant, :only => [:upload, :create]

  # This action renders the view to show all  prescriptions for the patient user,
  # 20 prescriptions will be shown per page.
  def index
    redirect_unless_user_is(:patient)
    @prescriptions = current_user.prescriptions.page(params[:page]).per(10)
    @ordered_prescriptions_ids =  Order.find_by_sql(["SELECT DISTINCT (prescription_id), taxname,tax FROM orders WHERE (user_id = :id )", {:id => current_user.id }]).map(&:prescription_id)
  end

  # This action renders the view for uploading prescription for a patient and populates the dropdown
  # list for the attribute 'Symptom' on the view where patient is uploading his prescription.
  def upload
    @prescription = current_user.prescriptions.build
  end

  # This action saves the uploaded prescription and redirects to the user's dashboard page.
  # This action also produces error messages if there are errors while uploading prescription.
  def create
    @prescription               = current_user.prescriptions.build
    @prescription_dosage_select = params[:prescription].delete(:dosage)
    @prescription_dosage_other  = params[:prescription].delete(:other_dosage) if @prescription_dosage_select == "Other"
    prescription_dosage         = @prescription_dosage_select
    prescription_dosage         = @prescription_dosage_other if @prescription_dosage_select == "Other"
    @dosage                     = Dosage.new(:quantity => prescription_dosage.to_i, :unit => :grams, :frequency => :daily)
    @prescription.update_attributes(params[:prescription].merge(:status => "uploaded",:dosage=>@dosage))
    if @prescription.save
      redirect_to review_prescription_path(@prescription)
    else
      respond_to do |format|
        format.html {
          render :action => :upload
        }
      end
    end
  end

  def new
  end

  def prescribe
  end

  def define_constant
    # constants moved to prescription model
  end

  # This action renders the view to show prescription detail of patient user.
  def show
    @prescription = current_user.prescriptions.find(params[:id])
  end

  def review
    @prescription = current_user.prescriptions.find(params[:id])
  end

end

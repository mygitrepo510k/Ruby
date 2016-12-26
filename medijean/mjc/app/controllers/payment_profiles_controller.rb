class PaymentProfilesController < ApplicationController
  
  before_filter :authenticate_user!

  # The Settings/New Payment Page
  # 
  # @route             GET /payment_profiles/new
  # @doctor_wireframe  https://projects.invisionapp.com/d/main#/console/381469/8768537/preview
  # @doctor_renders    payment_profiles/new.html.haml 
  def new
    @payment_profile = PaymentProfile.new
  end
  
  # The Settings/Update Payment Page
  # 
  # @route             GET /payment_profiles/edit
  # @doctor_wireframe  https://projects.invisionapp.com/d/main#/console/381469/8768537/preview
  # @doctor_renders    payment_profiles/edit.html.haml   
  def edit
    @payment_profile = current_user.payment_profile
    if @payment_profile.present?
      payment = PaymentProvider.new
      customer = payment.get_profile(@payment_profile.customer_id)
      @card_data = customer.card.data[0] if customer.card.present?
    else
      redirect_to :action => :new
    end
  end

  # Create Payment Information of Settings
  # 
  # This action saves the inputed new payment information into stripe and rendered payment_profiles/show
  # This action also produces error messages if there are errors while retirive the token of stripe
  # @route              POST /payment_profiles/create
  # @renders            GET  /payment_profiles/show
  def create
    payment = PaymentProvider.new    
    token = params[:stripe_token]
    customer = payment.create_profile(token, current_user.name, current_user.email)

    @payment_profile = PaymentProfile.new
    @payment_profile.user_id = current_user.id
    @payment_profile.customer_id = customer.customer_id

    if @payment_profile.save
      flash[:notice] = t("settings.payment.successfully_saved")
      @card_data = customer.card.data[0] if customer.card.present?
      render 'payment_profiles/show'
    else
      flash[:notice] = customer.message
      #session[:return_to] ||= request.referer
      #redirect_to session[:return_to]
      @card_data = customer.card.data[0] if customer.card.present?
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @payment_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # Edit Payment Information of Settings
  # 
  # This action updates the inputed new payment information into stripe and rendered payment_profiles/show
  # This action also produces error messages if there are errors while retirive the token of stripe
  # @route              PUT /payment_profiles/update
  # @renders            GET /payment_profiles/show  
  def update
    @payment_profile = current_user.payment_profile
    payment = PaymentProvider.new
    description = current_user.email
    token = params[:stripe_token]
    customer = payment.update_profile(@payment_profile.customer_id, token, description)    
    @payment_profile.customer_id = customer.customer_id
    
    if @payment_profile.save
      flash[:notice] = t("settings.payment.successfully_updated")
      @card_data = customer.card.data[0]
      render 'payment_profiles/show'
    else
      flash[:notice] = customer.message      
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
    end  
  end

end

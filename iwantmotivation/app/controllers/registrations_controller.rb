class RegistrationsController < Devise::RegistrationsController

  def new
    @parent_cat = []
    @sub_cat=[]
    temp = []
    Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>0}, :order=>'id DESC').each_with_index do |ct, index|
      @parent_cat.push([ct.name,ct.id])
      ct.subcategories.each do |sub_cat|
        temp.push([sub_cat.id,sub_cat.name])
      end
      @sub_cat.push([ct.id, temp])
      temp=[]
    end
    
    @plan = params[:plan]    
    if @plan && ENV["ROLES"].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to root_path, :notice => 'Please select a subscription plan below.'
    end
  end

  def create
    #render :text => params.inspect and return
    @amount = (User::MEMBER_AMOUNT[params[:plan].to_sym].to_f*100).to_i    
    if params[:payment_mode] == "credit_card"
      charge = nil    
      card_token = params[:payment_token]
      mail = params[:user][:email]

      begin      
        charge = Stripe::Charge.create(
          :amount => @amount,
          :currency => "usd",
          :card => card_token,
          :description => mail
        )        
        @token = charge.id
      rescue Stripe::CardError => e
        flash[:error] = "Failed to processing payment by credit card! Please try again later." unless request.xhr?
        redirect_to :back and return unless request.xhr?
        render :js=>"alert('Failed to processing payment! Please try again later.');" and return if request.xhr?
      end 
      super
    elsif params[:payment_mode] == "paypal"
      begin
        response = paypal_client.setup(
          payment_request( @amount.to_f/100, true ),
          success_payments_url,
          cancel_payments_url,
          pay_on_paypal: true,
          no_shipping: true
        )             
        @token = response.token        
        user = User.new(params[:user])
        user.amount=@amount.to_f/100
        user.payment_token=response.token
        user.transaction_cleared = false
        user.add_role(params[:plan])        
        user.save
        redirect_to response.redirect_uri
      rescue Paypal::Exception::APIError => e 
        flash[:error] = "Failed to processing payment by paypal! Please try again later." unless request.xhr?
        redirect_to :back and return unless request.xhr?
        render :js=>"alert('Failed to processing payment! Please try again later.');" and return if request.xhr?
      end
    end
    # *-*-*-*-*-* Send mail
    UserMailer.signed_success(mail, 'Signed Success', 'Thanks').deliver
    flash[:success] = "<b>Well done</b>! You have successfully added.".html_safe unless request.xhr?
  end
  def update
    @user = current_user
    
    #render :text => params.inspect and return

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    UserMailer.updated_user(@user).deliver
    flash[:success] = "<b>Well done</b>! You have successfully updated.".html_safe unless request.xhr?
  end

  def update_plan
    @user = current_user
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    if @user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      render :edit
    end
    UserMailer.updated_plan(@user).deliver
    flash[:success] = "<b>Well done</b>! You have successfully updated.".html_safe unless request.xhr?
  end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end

  private
  def build_resource(*args)
    super
    if params[:plan]
      resource.add_role(params[:plan])
    end
    if params[:payment_mode] == "credit_card"
      resource.set_payment( @token, @amount.to_f/100, true )
    elsif params[:payment_mode] == "paypal"
      resource.set_payment( @token, @amount.to_f/100, false )
    end
  end
end

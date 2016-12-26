class UsersController < ApplicationController
  before_filter :authenticate_user!, :except =>[:paypal_success, :paypal_cancel, :handle_callback, :check_screen_name]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def paypal_success
    handle_callback do |user|
      user.amount = User::MEMBER_AMOUNT[user.roles.last.name.to_sym]
      response = paypal_client.subscribe!(user.payment_token, recurring_request(user.amount.to_f))
      #response = paypal_client.checkout!(user.payment_token, params[:PayerID], payment_request(user.amount, true) )      
      #user.identifier = response.payment_info.first.transaction_id
      user.identifier = response.recurring.identifier
      user.transaction_cleared = true
      user.save!      
      flash[:notice] = 'Payment Transaction Completed'
      sign_in (user)
      home_welcome_path
    end
  end

  def paypal_cancel
    handle_callback do |user|
      user.destroy
      flash[:warn] = 'Payment Request Canceled'
      new_user_registration_path
    end
  end

  def handle_callback
    user = User.find_by_payment_token! params[:token]
    @success_uri = yield user
    render :partial=>'users/close_payment_flow'
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    if @user.update_attributes(params[:user])
      @user.update_plan(role) unless role.nil?
      redirect_to root_path, :notice => "User updated."
    else
      redirect_to root_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to root_path, :notice => "User deleted."
    else
      redirect_to root_path, :notice => "Can't delete yourself."
    end
  end

  def profile    
    @partner = current_user
  end

  def change_city
    @user = User.find(params[:id])    
    @user.user_info.city = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

  def change_state
    @user = User.find(params[:id])    
    @user.user_info.state = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

  def change_country
    @user = User.find(params[:id])    
    @user.user_info.country = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

  def change_cch_philosophy
    @user = User.find(params[:id])    
    @user.coachcounselor.philosophy = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end
  
  def change_cch_experience
    @user = User.find(params[:id])    
    @user.coachcounselor.experience = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

  def change_cch_helppeople
    @user = User.find(params[:id])    
    @user.coachcounselor.helppeople = params[:update_value]
    if @user.save
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

end
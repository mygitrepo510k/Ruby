class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin
  
  def index
    @users = User.all.reject{|u| u.email == 'parknow@admin.com'}    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new
    @user.auth_tokens.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  def edit
    @user = User.find(params[:id])    
    if @user.present?
      @author = @user.auth_tokens      
    end    
  end
  
  def create
    @user = User.new(user_params)    
    respond_to do |format|
      if @user.save
        if params[:user][:auth_tokens].present?
          auth = @user.auth_tokens.build(auth_params)
          auth.save
        end
        format.html { redirect_to action: :index}
        flash[:notice] = 'User was successfully created.' 
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @users.update_attributes(user_params)

        format.html { redirect_to action: :index}
        flash[:notice] = 'User was successfully updated.'
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
    end
    respond_to do |format|
      format.html { redirect_to admin_users_path }
      format.json { head :no_content }
    end
  end

  def new_auth_token
    @user = User.find(params[:id])
    @author = @user.auth_tokens.build
  end

  def create_auth_token
    device_id     = params[:auth_token][:device_id]
    device_type   = params[:auth_token][:device_type]
    app_type      = params[:auth_token][:app_type] 
    user = User.find(params[:auth_token][:user_id])
    device = user.auth_tokens.where(device_id:device_id,app_type:app_type,device_type:device_type)
    
    respond_to do |format|
      if device.present?
        format.html { redirect_to action: :index}
        flash[:notice] = 'This auth_token was saved already'
        format.json { head :no_content }
      else
        author = user.auth_tokens.build(device_id:device_id,device_type:device_type,app_type:app_type)
        if author.save
          format.html { redirect_to action: :index}
          flash[:notice] = 'Saved successfully'
          format.json { head :no_content }
        else
          format.html { render action: :index }
          format.json { render json: @date.errors, status: :unprocessable_entity }
        end        
      end
    end    
  end

  def edit_auth_token
    @author = AuthToken.find(params[:id])
    @user = @author.user
  end

  def update_auth_token
    @author = AuthToken.find(params[:id])
    respond_to do |format|
      if @author.update_attributes(device_id:params[:auth_token][:device_id],device_type:params[:auth_token][:device_type],app_type:params[:auth_token][:app_type])
        format.html { redirect_to admin_users_path }
        format.json { head :no_content}
      else
        format.html { redirect_to admin_users_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end      
    end
  end

  def destroy_auth_token
    @author = AuthToken.find(params[:id])
    if @author.present?
      @author.destroy
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { head :no_content }
    end
  end
  
  private
    def user_params
      if params[:user][:current_password].present?
        params.require(:user).permit(:email, :password, :password_confirmation,:current_password)
      else
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
    def auth_params
      params[:user].require(:auth_tokens).permit(:device_id, :device_type, :app_type) if params[:user][:auth_tokens].present?
    end
end


  
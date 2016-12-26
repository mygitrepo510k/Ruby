class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin

  def index
    if params[:search].present?
      @users = User.search(params[:search]).paginate(page: params[:page], :per_page => 10)
    else
      @users = User.all.paginate(page: params[:page], :per_page => 10)  
    end
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page], :per_page => 10)
  end
  # The User profile update
  #
  # @route            
  # @wireframe    
  def update
    @user=User.find(params[:id])
    @user.assign_attributes(avatar:params[:user][:avatar]) if params[:user][:avatar].present?    
    respond_to do |format|
      if @user.save
        format.html { redirect_to action: :index}
        flash.now[:notice] = 'Successfully updated user'
      else
        format.html { render action: :edit_user }
        format.json { render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  
  def account_settings
  end

  def notification_settings
  end

  def settings
  end
  # The User Profile Delete
  #
  # @route            GET /admin/delete_user
  # @wireframe        
  
  def delete_user
    @user = User.find(params[:id])
    @user.destroy unless @user.nil?
    respond_to do |format|
      format.html { redirect_to action: :index}
      format.json { head :no_content}
    end
  end

  # The User Profile Inactive
  #
  # @route            GET /admin/inactive
  # @wireframe          
  def inactive
    @user = User.find(params[:id])
    @user.update_attribute(:active, !@user.active)
    redirect_to :action => :index and return
  end
end
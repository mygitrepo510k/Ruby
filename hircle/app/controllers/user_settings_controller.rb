class UserSettingsController < ApplicationController
  
  # layout "user_settings"
   
  def index 
    @user = User.find(current_user.id)
       
    respond_to do |format|
      format.html
    end
  end
  
  def save_search
    if !params[:city].nil? and !params[:state].nil? and !params[:zip].nil?
                 
      @search_exist = UserSetting.find_by_user_id(current_user.id)
      
      if !@search_exist
        @search = UserSetting.create(:user_id => current_user.id, :search_city => params[:city], :search_state => params[:state], :search_zip_code => params[:zip])         
      else
        UserSetting.update_all(:user_id => current_user.id,:search_city => params[:city], :search_state => params[:state], :search_zip_code => params[:zip])
      end
    end
    
    render :json => @search   
  end
  
  def save_zone
    if !params[:zone].nil? 
      @search_exist = UserSetting.find_by_user_id(current_user.id)
      
      if !@search_exist
        @search = UserSetting.create(:user_id => current_user.id, :time_zone => params[:zone])         
      else
        UserSetting.update_all(:user_id => current_user.id, :time_zone => params[:zone])
      end
    end
    
    render :json => @search   
  end
  
  def cancel_account
    if !params[:cancel].nil? 
      @search_exist = UserSetting.find_by_user_id(current_user.id)
      
      if !@search_exist
        @search = UserSetting.create(:user_id => current_user.id, :account_status => params[:cancel])         
      else
        UserSetting.update_all(:user_id => current_user.id, :account_status => params[:cancel])
      end
    end
    
    render :json => @search   
  end
  
  def save_privacy
    if !params[:privacy].nil? 
      @search_exist = UserSetting.find_by_user_id(current_user.id)
      
      if !@search_exist
        @search = UserSetting.create(:user_id => current_user.id, :privacy => params[:privacy])         
      else
        UserSetting.update_all(:user_id => current_user.id, :privacy => params[:privacy])
      end
    end
    
    render :json => @search
  end
  
end

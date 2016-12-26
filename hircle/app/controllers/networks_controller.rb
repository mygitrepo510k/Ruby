class NetworksController < ApplicationController

  has_scope :search

  def index
  end

  def connect
    @users = current_user.search_users(params[:search])
  end

  def connected
  	ids =  params[:ids].split(",")
  	ids.each do |id|
      current_user.user_followings.create(:contact_id => id)
    end
    @connected_ids = ids.size
  end

  def apccept
    user_contact = current_user.user_followers.find_by_user_id(params[:user_id])
    user_contact.connected = true
    user_contact.save
    redirect_to root_path
  end

end

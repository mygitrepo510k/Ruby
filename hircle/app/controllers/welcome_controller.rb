class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    puts "In the index method of welcome controller =>#{current_user.role.name} "
    # case current_user.role
    #      when Role.find_by_name("Admin")
    #        redirect_to :controller=>"administrator",:action=>"index"
    #    end
    @is_job_seeker = params[:job_seeker].nil?

    if current_user
  	  users = User.where("email != ?", current_user.email) 
      users.each do |user| 
        Friend.make_friend(current_user, user)
      end
      @subscribe_channels = [] 

      current_user.friends.each do |friend| 
      	 @subscribe_channels <<  {:channel => friend.channel,
											      	   	:email => friend.friend.email,
											      	   	:recipient_id => friend.friend_id,
											      	   	:name=>friend.friend.full_name
											      	   }
      end 
    end    
  end
end

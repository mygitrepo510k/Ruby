module Endpoints
  class Accounts < Grape::API

    resource :accounts do

      # Accounts API test
      # /api/v1/accounts/ping
      # results  'gwangming'
      get :ping do
        { :ping => 'gwangming' }
      end

      # Get User account info
      # GET: /api/v1/accounts/user
      # parameters:
      #   token:    String *required
      # results: 
      #   return user data json
      get :user do
        user = User.find_by_token params[:token]        
        if user.present?
          {success: {user_name:user.user_name,email:user.email,phone:user.phone,social:user.from_social.capitalize,avatar:user.avatar_url, created_events:user.my_events_count, attend_events:user.attend_events_count}}
        else
          {:failure => "cannot find user"}
        end
      end

      # Get contact info
      # GET: /api/v1/accounts/contact_info
      # parameters:
      #   token:      String *required
      #   contact_id  String *required
      # results: 
      #   return user data json
      get :contact_info do
        user = User.find_by_token params[:token]        
        if user.present?
          contact = User.where(id:params[:contact_id]).first
          if contact.present?
            {success: {user_name:contact.user_name,email:contact.email,phone:contact.phone,social:contact.from_social.capitalize,avatar:contact.avatar_url, created_events:contact.my_events_count, attend_events:contact.attend_events_count}}
          else
            {:failure => "cannot find contact"}
          end          
        else
          {:failure => "cannot find user"}
        end
      end


      # Get User notifications setting info
      # GET: /api/v1/accounts/notifications_setting
      # parameters:
      #   token:    String *required
      # results: 
      #   return user notification settings data json
      get :notifications_setting do
        user = User.find_by_token params[:token]        
        if user.present?
          {success: {event_reminders:user.event_reminders,chat_notifications:user.chat_notifications,new_friend_events:user.new_friend_events,people_joining_events:user.people_joining_events,people_leaving_events:user.people_leaving_events,event_changes:user.event_changes}}
        else
          {:failure => "cannot find user"}
        end
      end

      ##########################################################################################
      #  ACCOUNT SETTINGS                                                                      #
      ##########################################################################################
      
      # Upload image
      # POST: /api/v1/accounts/upload_avatar
      # parameters:
      #   token:    String *required
      #   avatar:   Image Data *required
      # results: 
      #   return success string
      post :upload_avatar do
        user = User.find_by_token params[:token]
        return {failure: 'Please select avatar'} if params[:avatar].blank?
        if user.present?
          user.assign_attributes(avatar:params[:avatar])
          if user.save              
            {:success => user.avatar_url}
          else
            {:failure => 'invalid image data'}
          end
        else
          {:failure => "cannot find user"}
        end
      end


      # Change User email address
      # /api/v1/accounts/change_email
      # PARAMS(token, email)
      post :change_email do
        user = User.find_by_token params[:token]
        email = params[:email]
        if user.present?
          user.update_attribute(:email, email)
          {success: {key:'email',str:"successfully changed email"}}
        else
          {:failure => "cannot find user"}
        end
      end
      # Change User Name
      # /api/v1/accounts/change_user_name
      # PARAMS(token,user_name)
      post :change_user_name do
        user = User.find_by_token params[:token]
        user_name = params[:user_name]
        if user.present?
          user.update_attribute(:user_name,user_name)          
          {success: {key:"user_name",str:"successfully changed user name"}}
        else
          {:failure => "cannot find user"}
        end
      end

      # Change Phone number
      # POST: /api/v1/accounts/change_phone
      # parameters:
      #   token:    String *required
      #   phone:    String *required
      # results: 
      #   return success string
      post :change_phone do
        user = User.find_by_token params[:token]
        phone = params[:phone]
        if user.present?
          user.update_attribute(:phone,phone)          
          {success: {key:'phone', str:"successfully changed phone number"}}
        else
          {:failure => "cannot find user"}
        end
      end

      
      # Change Password
      # /api/v1/accounts/change_password
      # PARAMS(token,old_pswd, new_pswd, confirm_pswd)
      post :change_password do
        user = User.find_by_token params[:token]
        old_pswd      = params[:old_pswd]
        new_pswd      = params[:new_pswd]
        confirm_pswd  = params[:new_pswd]
        return {failure: "check your new password and confirm password"} if new_pswd != confirm_pswd
        if user.present?
          if user.valid_password?(old_pswd)
            user.password               = new_pswd
            user.password_confirmation  = confirm_pswd
            if user.save
              {success: {key:'password',str:"successfully changed password"}}
            else
              {failure: user.errors.messages}
            end
          end
        else
          {:failure => "cannot find user"}
        end
      end

      ########################## settings ###########################
      
      # POST: /api/v1/accounts/event_messages_to_your_phone
      # parameters:
      #   token:                              String   *required
      #   event_messages_to_your_phone        Boolean  *required
      #   dev_id                              String   *required
      # results: 
      #   return success string
      post :event_messages_to_your_phone do
        user            = User.find_by_token params[:token]
        evt_msg         = params[:event_messages_to_your_phone]=="true" ? true : false
        if user.present?
          device = Device.where(dev_id:params[:dev_id]).first
          if device.present?          
            device.update_attribute(:enabled_event_message, evt_msg)
            {success: {key:'event_messages_to_your_phone',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end        
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/event_invitations_to_your_phone
      # parameters:
      #   token:                              String   *required
      #   event_messages_to_your_phone        Boolean  *required
      #   dev_id                              String   *required
      # results: 
      #   return success string
      post :event_invitations_to_your_phone do
        user            = User.find_by_token params[:token]
        evt_msg         = params[:event_invitations_to_your_phone]=="true" ? true : false
        return {failure:'please input device id'} unless params[:dev_id].present?
        if user.present?
          device = Device.where(dev_id:params[:dev_id]).first
          if device.present?            
            device.update_attribute(:enabled_event_invite, evt_msg)
            {success: {key:'event_invitations_to_your_phone',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end        
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/chat_messages_to_your_phone
      # parameters:
      #   token:                              String    *required
      #   event_messages_to_your_phone:       Boolean   *required
      #   dev_id:                             Boolean   *required
      # results: 
      #   return success string
      post :chat_messages_to_your_phone do
        user            = User.find_by_token params[:token]
        evt_msg         = params[:chat_messages_to_your_phone] == "true" ? true : false
        if user.present?
          device = Device.where(dev_id:params[:dev_id]).first          
          if device.present?
            device.update_attribute(:enabled_chat_message, evt_msg)
            {success: {key:'chat_messages_to_your_phone',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end        
        else
          {:failure => "cannot find user"}
        end
      end

      # Settings
      # GET: /api/v1/accounts/settings
      # parameters:
      #   token:          String  *required
      #   dev_id:         String  *required
      # results: 
      #   return success string
      get :settings do
        user = User.find_by_token params[:token]
        if user.present?
          device = Device.where(dev_id:params[:dev_id]).first
          if device.present?
            setting_info = {event_messages_to_your_phone:device.enabled_event_message,event_invitations_to_your_phone:device.enabled_event_invite,chat_messages_to_your_phone:device.enabled_chat_message}
            {success: setting_info}
          else
            {failure: "cannot find your device"}
          end          
        else
          {:failure => "cannot find user"}
        end
      end


      ############################ Notification Settings ############################

      # POST: /api/v1/accounts/event_reminders
      # parameters:
      #   token:                  String  *required
      #   event_reminders:        Boolean *required
      # results: 
      #   return success string
      post :event_reminders do
        user = User.find_by_token params[:token]
        event_reminders         = params[:event_reminders]
                
        if user.present?
          user.update_attribute(:event_reminders,event_reminders)
          if user.save
            {success: {key:'event_reminders',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/chat_notifications
      # parameters:
      #   token:                  String  *required
      #   chat_notifications:     Boolean *required
      # results: 
      #   return success string
      post :chat_notifications do
        user = User.find_by_token params[:token]
        value = params[:chat_notifications]
                
        if user.present?
          user.update_attribute(:chat_notifications,value)
          if user.save
            {success: {key:'chat_notifications',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/new_friend_events
      # parameters:
      #   token:                  String  *required
      #   new_friend_events:      Boolean *required
      # results: 
      #   return success string
      post :new_friend_events do
        user = User.find_by_token params[:token]
        value = params[:new_friend_events]
                
        if user.present?
          user.update_attribute(:new_friend_events,value)
          if user.save
            {success: {key:'new_friend_events',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/people_joining_events
      # parameters:
      #   token:                  String  *required
      #   people_joining_events:  Boolean *required
      # results: 
      #   return success string
      post :people_joining_events do
        user = User.find_by_token params[:token]
        value = params[:people_joining_events]
                
        if user.present?
          user.update_attribute(:people_joining_events,value)
          if user.save
            {success: {key:'people_joining_events',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # POST: /api/v1/accounts/people_leaving_events
      # parameters:
      #   token:                  String  *required
      #   people_leaving_events         Boolean *required
      # results: 
      #   return success string
      post :people_leaving_events do
        user = User.find_by_token params[:token]
        value = params[:people_leaving_events]
                
        if user.present?
          user.update_attribute(:people_leaving_events,value)
          if user.save
            {success: {key:'people_leaving_events',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      
      # POST: /api/v1/accounts/event_changes
      # parameters:
      #   token:                  String  *required
      #   event_changes         Boolean *required
      # results: 
      #   return success string
      post :event_changes do
        user = User.find_by_token params[:token]
        value = params[:event_changes] == "true" ? true : false
                
        if user.present?
          user.update_attribute(:event_changes,value)
          if user.save
            {success: {key:'event_changes',str:"successfully changed settings"}}
          else
            {failure: user.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end


      # Notification Settings
      # GET: /api/v1/accounts/notifications_setting
      # parameters:
      #   token:                  String  *required
      # results: 
      #   JSON data
      get :notifications_setting do
        user = User.find_by_token params[:token]        
        if user.present?
          {success: { event_reminders:user.event_reminders,
                      chat_notifications:user.chat_notifications,
                      new_friend_events:user.new_friend_events,
                      people_joining_events:user.people_joining_events,
                      people_leaving_events:user.people_leaving_events,
                      event_changes:user.event_changes}}
        else
          {:failure => "cannot find user"}
        end
      end


      # Add Friends
      # Post: /api/v1/accounts/friend
      # parameters:
      #   token:    String *required
      # results: 
      #   friend list json
      post :add_friend do
        user = User.find_by_token params[:token]
        name              = params[:name]
        friend_auth_id    = params[:friend_auth_id]
        email             = params[:email]
        avatar            = params[:avatar]
        from_social       = params[:social]
        if user.present?
          friend = friend_auth_id.present? ? Friend.where(friend_auth_id:friend_auth_id).first : Friend.where(email:email).first
          if friend.present?
            user.add_friend(friend)
            friend.add_user(user)
            {success: {id:friend.id.to_s,name:friend.name,friend_auth_id:friend.friend_auth_id,avatar:friend.avatar_url,is_new:"older"}}
          else
            friend = Friend.new(name:name,friend_auth_id:friend_auth_id, email:email, avatar:avatar,from_social:from_social)
            if friend.save
              user.add_friend(friend)
              friend.add_user(user)
              {success: {id:friend.id.to_s,name:friend.name, friend_auth_id:friend.friend_auth_id,email:friend.email,avatar:friend.avatar_url,is_new:"newer"}}
            else
              {failure: friend.errors.messages}
            end            
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Upload Friend's avatar
      # Post: /api/v1/accounts/friend_avatar_upload
      # parameters:
      #   token:      String *required
      #   friend_id:  String *required        #friend id
      #   avatar:     Image data *required
      # results: 
      #   friend list json
      post :friend_avatar_upload do
        user    = User.find_by_token params[:token]
        avatar  = params[:avatar]        
        if user.present?
          friend      = Friend.where(id:params[:friend_id]).first
          if friend.present?
            friend.update_attributes(avatar:avatar)
            {success: friend.avatar_url}
          else
            {:failure => "cannot find friend"}  
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get Friends
      # GET: /api/v1/accounts/friends
      # parameters:
      #   token:    String *required
      # results: 
      #   friend list json
      get :friends do
        user = User.find_by_token params[:token]        
        if user.present?
          friends = user.friends.map{|f| {id:f.id.to_s,name:f.name,email:f.email,avatar:f.avatar_url}}
          {success: friends}
        else
          {:failure => "cannot find user"}
        end
      end

      # CHAT API
      # POST: /api/v1/accounts/send_message
      # parameters:
      #    token:     String *required
      #    friend_id  String *required
      #    message    String *required
      # results:
      #    surccess string
      post :send_message do
        user = User.find_by_token params[:token]
        if user.present?          
          friend = Friend.find(params[:friend_id])
          devices = user.devices
          devices.each do |dev|
            dev.send_single_notification(message)
          end

          {success: friends}
        else
          {:failure => "cannot find user"}
        end
      end

      # Forgot password
      # GET: /api/v1/accounts/forgotten_password
      # parameters:
      #     email:     String *required
      get :forgotten_password do
        user = User.where(email:params[:email]).first
        if user.present?
          UserMailer.forgotten_password(user).deliver          
          {success: 'Email was sent successfully'}
        else
          {:failure => 'Cannot find this email'}
        end
      end

      # Setting API
      # POST: /api/v1/accounts/facebook_connect
      # parameters:
      #    token:         String *required
      #    facebook_uid   String *required
      # results:
      #    surccess string
      post :facebook_connect do
        user = User.find_by_token params[:token]
        if user.present?
          f_user = User.where(user_auth_id:params[:facebook_uid]).first
          if f_user.present?
            {failure: "this facebook is connected already"}
          else
            if user.update_attributes(user_auth_id:params[:facebook_uid])
              {success: "connected facebook account"}
            else
              {failure: user.errors.messages}
            end
          end
          
        else
          {:failure => "cannot find user"}
        end
      end

      # Setting API
      # POST: /api/v1/accounts/is_foreground
      # parameters:
      #    token:         String *required
      #    dev_id:        String *required
      # results:
      #    surccess string
      post :is_foreground do
        user = User.find_by_token params[:token]
        if user.present?
          device = User.devices.where(dev_id:params[:dev_id]).first
          if device.present?
            device.update_attribute(:badge_count,0)
            {success: "badge number is 0"}
          else
            {failure: "cannot find device"}
          end          
        else
          {:failure => "cannot find user"}
        end
      end
    end
    
  end
end
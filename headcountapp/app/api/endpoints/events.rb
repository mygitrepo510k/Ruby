module Endpoints
  class Events < Grape::API

    resource :events do

      # Events API test
      # /api/v1/events/ping
      # results  'events endpoints'
      get :ping do
        { :ping => 'events ednpoints' }
      end

      # Get Event info
      # GET: /api/v1/events/event
      # parameters:
      #   token:      String *required
      #   event_id:   String *required
      # results: 
      #   return event data json
      get :event do
        user = User.find_by_token params[:token]        
        if user.present?
          
        else
          {:failure => "cannot find user"}
        end
      end

      # Get all my events
      # GET: /api/v1/events/my_events
      # parameters:
      #   token:      String *required      
      # results: 
      #   return my events data json      
      get :my_events do
        user = User.find_by_token params[:token]
        if user.present?
          events = Event.rsvp_events(user)
          if events.present?
            #{success: events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state}}}
            {success:events}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get my previous events
      # GET: /api/v1/events/my_previous_events
      # parameters:
      #   token:      String *required
      # results: 
      #   return my events data json
      get :my_previous_events do
        user = User.find_by_token params[:token]
        if user.present?
          events = Event.my_previous_events(user)
          if events.present?
            #{success: events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state}}}
            {success:events}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get upcoming events
      # GET: /api/v1/events/upcoming_events
      # parameters:
      #   token:      String *required
      # results: 
      #   return my events data json
      get :upcoming_events do
        user = User.find_by_token params[:token]
        if user.present?
          events = Event.user_upcomming_events(user)
          if events.present?
            {success: events}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get previous events
      # GET: /api/v1/events/previous_events
      # parameters:
      #   token:      String *required
      # results: 
      #   return my events data json
      get :previous_events do
        user = User.find_by_token params[:token]
        if user.present?
          events = Event.user_previous_events(user)
          if events.present?
            #{success: events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state}}}
            {success:events}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get last events
      # GET: /api/v1/events/last_events
      # parameters:
      #   token:      String *required
      # results: 
      #   return my events data json
      get :last_events do
        user = User.find_by_token params[:token]
        if user.present?
          events = user.events.last_events
          if events.present?
            {success: events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state}}}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get events photos
      # GET: /api/v1/events/event_photos
      # parameters:
      #   token:      String *required
      # results: 
      #   return my event's photo list
      get :event_photos do
        user = User.find_by_token params[:token]
        if user.present?
          events = user.events
          if events.present?
            {success: events.map{|e| {id:e.id.to_s, name:e.name, img:e.main_img}}}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Create Event
      # POST: /api/v1/events/create_event
      # parameters:
      #   token:            String *required
      #   save_state:       String *required
      #   name:             String *required
      #   location:         String *required
      #   date:             String *required      2014-1-14,14:30
      #   description:      String *required
      #   enable_chat:      Boolean *required     true or false
      #   photo:            image data
      #   friend_ids:       String *required
      #   access_token:     String
      # results: 
      #   return my events data json
      post :create_event do
        user = User.find_by_token params[:token]
        name          = params[:name]
        location      = params[:location]        
        date          = DateTime.strptime(params[:date].delete(' '),"%Y-%m-%d,%H:%M")
        friend_ids    = params[:friend_ids].delete(' ')
        description   = params[:description]
        enable_chat   = params[:enable_chat]
        photo         = params[:photo]
        save_state    = params[:save_state]
        access_token  = params[:access_token]
        return {failure: 'cannot find params photo'} if params[:photo].blank?
        if user.present?
          
          event = user.events.build(name:name,event_date:date,friend_ids:friend_ids,description:description,enable_chat:enable_chat,save_state:save_state)
          if event.save
            photo = event.build_photo(photo:photo)
            photo.save

            gl = event.build_geo_location(address:location)
            gl.save
            {success: "created event"}
          else
            {:failure => event.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end
      

      # Update Event
      # POST: /api/v1/events/update_event
      # parameters:
      #   token:            String *required
      #   event_id          String *required
      #   name:             String
      #   location:         String
      #   date:             String
      #   description:      String
      #   enable_chat:      Boolean
      #   photo:            Image data
      #   friend_ids:       String
      #   access_token:     String
      # results: 
      #   return my events data json
      post :update_event do
        user = User.find_by_token params[:token]
        name          = params[:name]
        location      = params[:location]        
        date          = DateTime.strptime(params[:date].delete(' '),"%Y-%m-%d,%H:%M")
        friend_ids    = params[:friend_ids].delete(' ')
        description   = params[:description]
        enable_chat   = params[:enable_chat]
        photo         = params[:photo]

        return {failure: 'cannot find params photo'} if params[:photo].blank?
        if user.present?
          event = user.update_attributes(name:name,event_date:date,friend_ids:friend_ids,description:description,enable_chat:enable_chat)
          if event.save
            photo = event.photo.present? ? event.photo.assign_attributes(photo:photo) : event.build_photo(photo:photo)
            photo.save
            gl = event.geo_location.present? ? event.geo_location.assign_attributes(address:location) : event.build_geo_location(address:location)
            gl.save
            event.send_event_change_notification
            {success: "updated event"}
          else
            {:failure => event.errors.messages}
          end
        else
          {:failure => "cannot find user"}
        end
      end
      
      # Delete Event
      # POST: /api/v1/events/delete_event
      # parameters:
      #   token:            String *required
      #   event_id          String *required
      # results: 
      #   return success string
      post :delete_event do
        user = User.find_by_token params[:token]
        if user.present?
          event = user.events.where(id:params[:event_id]).first
          if event.present?
            event.destroy
            {success: "deleted event"}
          else
            {:failure => "cannot find event"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Get Shared photos from event
      # GET: /api/v1/events/get_shared_photos
      # parameters:
      #   token:            String *required
      #   event_id:       String *required
      # results: 
      #   return my events data json
      get :get_shared_photos do
        user = User.find_by_token params[:token]
        if user.present?
          event = Event.where(id:params[:event_id]).first
          if event.present?            
            {success: event.get_shared_photos}            
          else
            {:failure => "can't find event"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Share photo to event
      # POST: /api/v1/events/share_photo
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      #   photo:            Image data      
      # results: 
      #   return my events data json
      post :share_photo do
        user = User.find_by_token params[:token]
        photo         = params[:photo]
        if user.present?
          event = Event.where(id:params[:event_id]).first          
          if event.present?            
            share_photo = event.shared_photos.build(user_id:user.id.to_s)
            if share_photo.save
              photo = share_photo.build_photo(photo:photo)
              photo.save
              {success: 'shared photo'}
            else
              {:failure => share_photo.errors.messages}
            end
          else
            {:failure => "can't find event"}
          end
        else
          {:failure => "can't find user"}
        end
      end

      # Get Event
      # GET: /api/v1/events/event_detail
      # parameters:
      #   token:            String *required
      #   id:               String *required
      get :event_detail do
        user = User.find_by_token params[:token]
        if user.present?
          event = Event.find(params[:id])
          if event.present?
            {success: event.details(user)}
          else
            {failure: "cannot find your events"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Accept Event
      # POST: /api/v1/events/accept_event
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      post :accept_event do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = Event.find(params[:event_id])
          if event.accept(user)
            {success: "successfully accepted event"}
          else
            {:failure => "cannot accept event"}
          end
        else
          {:failure => "cannot find user"}
        end
      end


      # Unaccept Event
      # POST: /api/v1/events/unaccept_event
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      post :unaccept_event do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = Event.find(params[:event_id])
          if event.unaccept(user)
            {success: "successfully unaccepted event"}
          else
            {:failure => "cannot unaccept event"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Invited friends
      # GET: /api/v1/events/invited_friends
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      get :invited_friends do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = event.find(params[:event_id])
          firneds = event.invited_friends.map{|f| {id:f.id.to_s,name:f.name,email:f.email,avatar:f.avatar_url,accepted:f.accepted_event(event)}}
          if friends.present?
            {success: friends}
          else
            {:failure => "cannot find invited friends"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Accepted friends
      # GET: /api/v1/events/accepted_friends
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      get :accepted_friends do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = event.find(params[:event_id])
          firneds = event.accepted_friends.map{|f| {id:f.id.to_s,name:f.name,email:f.email,avatar:f.avatar_url,accepted:f.accepted_event(event)}}
          if friends.present?
            {success: friends}
          else
            {:failure => "cannot find accepted friends"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # UnAccepted friends
      # GET: /api/v1/events/unaccepted_friends
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      get :accepted_friends do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = event.find(params[:event_id])
          firneds = event.unaccepted_friends.map{|f| {id:f.id.to_s,name:f.name,email:f.email,avatar:f.avatar_url,accepted:f.accepted_event(event)}}
          if friends.present?
            {success: friends}
          else
            {:failure => "cannot find unaccepted friends"}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # Have not rsvp friends
      # GET: /api/v1/events/have_not_rsvp_friends
      # parameters:
      #   token:            String *required
      #   event_id:         String *required
      # results: 
      #   return success string
      get :have_not_rsvp_friends do
        user  = User.find_by_token params[:token]        
        if user.present?
          event = event.find(params[:event_id])
          firneds = event.have_not_rsvp_friends.map{|f| {id:f.id.to_s,name:f.name,email:f.email,avatar:f.avatar_url,accepted:f.accepted_event(event)}}
          if friends.present?
            {success: friends}
          else
            {:failure => "cannot find have not rsvp friends"}
          end
        else
          {:failure => "cannot find user"}
        end
      end


      # Send message
      # POST: /api/v1/events/send_message
      # parameters:
      #   token:            String *required
      #   chat_id:          String 
      #   message:          String *required
      # results: 
      #   return success string
      post :send_message do
        user  = User.find_by_token params[:token]
        msg = params[:message]
        if user.present?
          chat = Chat.find(params[:chat_id])
          if chat.user.id == user.id
            contact = User.where(id:chat.contacted_id).first
          else
            contact = chat.user
          end
          return {:failure => "cannot find contact"} if contact.nil?
          chat.send_single_notification(user, contact, msg)
          {success: "successfully sent message"}          
        else
          {:failure => "cannot find user"}
        end
      end


      # Get messages
      # GET: /api/v1/events/get_messages      
      # parameters:
      #  token:            String *required
      #  event_id:         String *required
      #  contact_id:       String *required
      # results: 
      #   return success string
      get :get_messages do
        user  = User.find_by_token params[:token]
        if user.present?
          event = Event.find(params[:event_id])
          return {failure:'cannot group chat'} if event.enable_chat == false
          chat = event.chats.where(contacted_id:params[:contact_id]).first

          if chat.present?
            {success: {chat_id:chat.id.to_s,messages:chat.get_messages(user)}}
          else
            chat = user.chats.build(contacted_id:params[:contact_id], event_id:params[:event_id])
            chat.save
            {success: {chat_id:chat.id.to_s,messages:chat.get_messages(user)}}
          end
        else
          {:failure => "cannot find user"}
        end
      end

      # clear message conversations
      # POST: /api/v1/events/clear_messages
      # parameters:
      #   token:            String *required
      #   chat_id:          String 
      #   message:          String *required
      # results: 
      #   return success string
      post :clear_messages do
        user  = User.find_by_token params[:token]
        
        if user.present?
          chat = Chat.find(params[:chat_id])
          if chat.present?
            chat.destroy_conversations
            {success: "successfully clear all conversations for this event"}
          else
            {failure: "cannot find this conversations"}
          end          
        else
          {:failure => "cannot find user"}
        end
      end      

    end
  end
end

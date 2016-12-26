class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  EVENT_STATE = ["live"]
  
  field :name,          :type => String
  #field :location,			:type => String
  field :event_date,		:type => DateTime
  field :description, 	:type => String
  field :enable_chat,   :type => Boolean
  field :save_state,    :type => Boolean
  field :rsvp_state,		:type => Boolean					# selected status
  
  field :event_state,   :type => String         #published? or draft?
  
  field :friend_ids,              :type => String  
  field :accepted_friend_ids,     :type => String
  field :unaccepted_friend_ids,   :type => String
  #field :not_rsvp_friend_ids,     :type => String

  belongs_to :user

  has_one :photo,  		             :as => :photoble,       dependent: :destroy
  has_many :shared_photos
  has_many :chats
  
  has_one :geo_location

  validates_presence_of :user_id, :name, :event_date, :description

  scope :upcomming_events, -> {where(:event_date.gte => Time.zone.now).order_by('created_at ASC')}
  scope :previous_events, -> {where(:event_date.lt => Time.zone.now).order_by('created_at DESC')}
  scope :last_events, -> {order_by('created_at DESC')}
  
  def friends
    if friend_ids.present?
      Friend.in(id:friend_ids.split(","))
    else
      []
    end
  end

  def invited_friends
  	self.friends
  end


  def accepted_friends
    if accepted_friend_ids.present?
      User.in(id:accepted_friend_ids.split(","))
    else
      []
    end
  end

  def unaccepted_friends
    if unaccepted_friend_ids.present?
      User.in(id:unaccepted_friend_ids.split(","))
    else
      []
    end
  end

  def have_not_rsvp_friends
    f_ids = friend_ids.split(",")
    
    if_token = invited_friends.map(&:friend_auth_id)          # friend
    af_token = accepted_friends.map(&:user_auth_id)             # user
    uf_token = unaccepted_friends.map(&:user_auth_id)           # user

    not_rsvp_friend_token =  if_token - (af_token | uf_token)
    Friend.in(friend_auth_id:not_rsvp_friend_token)
  end

  def accept(user)
    event = Event.find(self.id.to_s)
    af_ids = event.accepted_friend_ids.present? ? event.accepted_friend_ids.split(",") : []
    uf_ids = event.unaccepted_friend_ids.present? ? event.unaccepted_friend_ids.split(",") : []
    af_ids.delete(user.id.to_s)
    uf_ids.delete(user.id.to_s)          
    af_ids << user.id.to_s
    event.update_attributes(accepted_friend_ids:af_ids.join(","),unaccepted_friend_ids:uf_ids.join(","))    
  end

  def accepted?(user)
    return false if self.accepted_friend_ids.blank?
    self.accepted_friend_ids.split(",").include?(user.id.to_s)
  end

  def invited?(user)
    f_auth_ids = invited_friends.map(&:friend_auth_id)
    f_auth_ids.include?(user.user_auth_id)
  end

  def unaccept(user)
    event = Event.find(self.id.to_s)
    af_ids = event.accepted_friend_ids.present? ? event.accepted_friend_ids.split(",") : []
    uf_ids = event.unaccepted_friend_ids.present? ? event.unaccepted_friend_ids.split(",") : []
    af_ids.delete(user.id.to_s)
    uf_ids.delete(user.id.to_s)          
    uf_ids << user.id.to_s
    event.accepted_friend_ids = af_ids.join(",")
    event.unaccepted_friend_ids = uf_ids.join(",")
    event.save
  end
  
  def unaccepted?(user)
    return false if self.unaccepted_friend_ids.blank?
    self.unaccepted_friend_ids.split(",").include?(user.id.to_s)
  end

  def date
    dt = self.event_date
    if dt.present?
      dt.strftime("%B %d, %H:%M%P")
    else
      ""
    end
  end

  def main_img
    self.photo_url
  end

  def photo_url
    return '' if self.photo.nil?
    photo = self.photo
    if photo.present?
      if Rails.env.development?
        return "http://192.168.0.55:3000" + photo.photo_url
      else
        return photo.photo_url
      end
    else
      url = ''
    end
  end

  def tags
    ['Racecurse','Horse', 'Racing']
  end

  def comments_count
    Random.rand(9)+10
  end
  
  def notification_state
    Random.rand(2) > 0
  end

  def has_rsvp_state
    self.rsvp_state.present? ? self.rsvp_state : ''
  end

  def location
    if self.geo_location.present?
      self.geo_location.address 
    else
      ''
    end
  end

  def location_lat_lang
    if self.geo_location.present?
      self.geo_location.coordinates
    else
      ''
    end
    
  end

  def details(user)
    e = self
    is_my_event = user.events.include?(e)
    accepted_friends = e.accepted_friends.present? ? e.accepted_friends.map{|f| {id:f.id.to_s,name:f.name,avatar:f.avatar_url}} : {}
    unaccepted_friends = e.unaccepted_friends.present? ? e.unaccepted_friends.map{|f| {id:f.id.to_s,name:f.name,avatar:f.avatar_url}} : {}
    invited_friends = e.invited_friends.present? ? e.invited_friends.map{|f| {id:f.id.to_s,name:f.name,avatar:f.avatar_url}} : {}
    have_not_rsvp_friends = e.have_not_rsvp_friends.present? ? e.have_not_rsvp_friends.map{|f| {id:f.id.to_s,name:f.name,avatar:f.avatar_url}} : {}
    s_photos = e.shared_photos.map{|sp| {id:sp.id,user_name:sp.user.name,photo:sp.photo_url}}
    { id:e.id.to_s, 
      name:e.name,
      user_name:e.user.name,
      location:e.location,
      geo_data:e.location_lat_lang, 
      event_date:e.event_date.present? ? e.event_date.strftime("%B %eth , %I:%M%P") : '', 
      photo:e.main_img,
      tags:e.tags,
      enable_chat:e.enable_chat,
      rsvp_state:e.has_rsvp_state,
      accepted_friends:accepted_friends, 
      unaccepted_friends:unaccepted_friends,
      have_not_rsvp_friends:have_not_rsvp_friends,
      description:e.description,
      shared_photos:s_photos,
      is_my_event:is_my_event,
      is_accepted:accepted?(user),
      is_unaccepted:unaccepted?(user)}
  end

  def self.rsvp_events(user)
    #events = Event.or({ :accepted_friends => /.*#{user.id.to_s}*./ }, { :unaccepted_friends => /.*#{user.id.to_s}*./}, {:user_id => user.id.to_s})
    ad_events = Event.where({ :accepted_friend_ids => /.*#{user.id.to_s}*./ })
    unad_events = Event.where({ :unaccepted_friend_ids => /.*#{user.id.to_s}*./})
    my_events = user.events
    events = ad_events | unad_events | my_events
    
    ad_event_ids = ad_events.map{|e| e.id.to_s}
    ud_event_ids = unad_events.map{|e| e.id.to_s}
    my_event_ids = my_events.map{|e| e.id.to_s}

    all_events = Event.in(id:events.map(&:id)).order_by('created_at ASC')
    events = all_events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.present? ? e.user.user_name : '',date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state,accepted:ad_event_ids.include?(e.id.to_s),unaccepted:ud_event_ids.include?(e.id.to_s),is_my_event:my_event_ids.include?(e.id.to_s)}}
  end
  
  def self.user_upcomming_events(user)
    friend = Friend.where(friend_auth_id:user.user_auth_id).first
    up_events = Event.upcomming_events
    if friend.present?
      events = up_events.where({ :friend_ids => /.*#{friend.id.to_s}*./ })
      ad_events = up_events.where({ :accepted_friend_ids => /.*#{user.id.to_s}*./ })
      unad_events = up_events.where({ :unaccepted_friend_ids => /.*#{user.id.to_s}*./})
      my_events = user.events.upcomming_events
      events = events | ad_events | unad_events | my_events
      
      event_ids    = events.map{|e| e.id.to_s}
      ad_event_ids = ad_events.map{|e| e.id.to_s}
      ud_event_ids = unad_events.map{|e| e.id.to_s}
      my_event_ids = my_events.map{|e| e.id.to_s}

      all_events = up_events.in(id:events.map(&:id)).order_by('created_at ASC')
      events = all_events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.present? ? e.user.user_name : '',date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state,accepted:ad_event_ids.include?(e.id.to_s),unaccepted:ud_event_ids.include?(e.id.to_s),is_my_event:my_event_ids.include?(e.id.to_s),invited_friends_count:e.invited_friends.count, accepted_count:ad_event_ids.count,unaccepted_count:ud_event_ids.count}}
    else
      []
    end    
  end

  def self.my_previous_events(user)        
    all_events = user.events.previous_events.order_by('event_date ASC')
    events = all_events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state,accepted:false,unaccepted:false,is_my_event:true}}
  end

  def self.user_previous_events(user)
    ad_events = Event.previous_events.where({ :accepted_friend_ids => /.*#{user.id.to_s}*./ })
    unad_events = Event.previous_events.where({ :unaccepted_friend_ids => /.*#{user.id.to_s}*./})
    my_events = user.events.previous_events
    events = ad_events | unad_events | my_events

    ad_event_ids = ad_events.map{|e| e.id.to_s}
    ud_event_ids = unad_events.map{|e| e.id.to_s}
    my_event_ids = my_events.map{|e| e.id.to_s}    
    
    all_events = Event.in(id:events.map(&:id)).order_by('created_at ASC')
    events = all_events.map{|e| {id:e.id.to_s,name:e.name,user_name:e.user.user_name,date:e.date,location:e.location,img:e.main_img,tags:e.tags,comments:e.comments_count,notification:e.notification_state,accepted:ad_event_ids.include?(e.id.to_s),unaccepted:ud_event_ids.include?(e.id.to_s),is_my_event:my_event_ids.include?(e.id.to_s),invited_friends_count:e.invited_friends.count, accepted_count:ad_event_ids.count,unaccepted_count:ud_event_ids.count}}
  end


  def self.friends_invite(user, event_name, friend_ids, access_token)
    sender_chat_id = "-#{user.user_auth_id}@chat.facebook.com"
    receiver_chat_ids = []
    friend_ids.each do |f_id|
      friend = Friend.in(id:f_id).first
      receiver_chat_ids << "-#{friend.friend_auth_id}@chat.facebook.com" if friend.present?
    end
    message_body = "You are invited this event, Event Title: #{event_name}"
    message_subject = "Invite to event"

    jabber_messages = []
    receiver_chat_ids.each do |r_id|
      j_message = Jabber::Message.new(r_id, message_body)
      j_message.subject = message_subject
      jabber_messages << j_message
    end

    client = Jabber::Client.new(Jabber::JID.new(sender_chat_id))
    client.connect
    
    jabber = Jabber::SASL::XFacebookPlatform.new(client,'788929617788505', access_token,'923ff7b466ca621c6c6402a4c39645c1')
    client.auth_sasl(jabber, nil)
    
    jabber_messages.each do |j_msg|
      client.send(j_msg)
    end
    
    client.close
  end

  def get_shared_photos
    user_ids = self.shared_photos.map{|sp| sp.user_id.to_s}.uniq
    share_photos = []
    user_ids.each do |u_id|
      usp = self.shared_photos.where(user_id:u_id).map{|sp| {id:sp.id.to_s, photo:sp.photo_url}}
      user  = User.find(u_id)
      if user.present?
        share_photos << {user:user.name, user_id:user.id.to_s, user_avatar:user.avatar_url, photos:usp}
      end
    end
    return share_photos
  end

  def send_event_change_notification
    users = User.in(user_auth_id:self.invited_friends.map(&:friend_auth_id))
    users.each do |user|
      user.send_event_change_notification(self) if user.event_changes == true
    end
  end

  def send_reminder_notification
    users = self.accepted_friends
    users.each do |user|
      user.send_event_change_notification(self) if user.event_changes == true
    end
  end

end
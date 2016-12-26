class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLES = ['admin', 'insights', 'tester', 'content creator', 'publisher', 'master admin']
  SOCIAL_STATE = %w[facebook twitter google]

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
         
  ## Database authenticatable
  field :email,                     :type => String, :default => ""
  field :user_name,                 :type => String, :default => ""
  field :phone,                     :type => String, :default => ""
  field :encrypted_password,        :type => String, :default => ""

  field :full_name,                 :type => String, :default => ""
  field :interest,                  :type => String, :default => ""
  
  field :location,                  :type => String, :default => ""
  field :country_code,              :type => String

  field :confirmed_value,           :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,      :type => String
  field :reset_password_sent_at,    :type => Time

  ## Rememberable
  field :remember_created_at,       :type => Time

  ## Trackable
  field :sign_in_count,             :type => Integer, :default => 0
  field :current_sign_in_at,        :type => Time
  field :last_sign_in_at,           :type => Time
  field :current_sign_in_ip,        :type => String
  field :last_sign_in_ip,           :type => String

  ## Confirmable
  # field :confirmation_token,      :type => String
  # field :confirmed_at,            :type => Time
  # field :confirmation_sent_at,    :type => Time
  # field :unconfirmed_email,       :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts,         :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,            :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,               :type => Time
  
  field :avatar,                    :type => String     # profile logo image

  field :role,                      :type => String
  field :active,                    :type => Boolean,   :default => true

  field :from_social,               :type => String,    :default => ""     # Social login status


  #field :access_token,              :type => String
  field :user_auth_id,              :type => String
  field :authentication_token,      :type => String
  before_save :ensure_authentication_token

  # ????
  #field :event_messages_to_your_phone,            :type => Boolean,   :default => true
  #field :event_invitations_to_your_phone,         :type => Boolean,   :default => false
  #field :chat_messages_to_your_phone,             :type => Boolean,   :default => false

  field :legal_notices,                           :type => String,    :default => ""
  field :help_faq,                                :type => String,    :default => ""
  field :basic_notifications,                     :type => String,    :default => ""

  # Settings NOtification
  field :event_reminders,           :type => Boolean,   :default => true
  field :chat_notifications,        :type => Boolean,   :default => false
  field :new_friend_events,         :type => Boolean,   :default => true
  field :people_joining_events,     :type => Boolean,   :default => false
  field :people_leaving_events,     :type => Boolean,   :default => false
  field :event_changes,             :type => Boolean,   :default => true

  

  field :friend_ids,                :type => String
  #has_many :friends
  has_many :events
  has_many :devices
  has_many :chats
  has_one :geo_location

  has_many :shared_photos
  
  def name
    self.user_name.present? ? self.user_name : ''
  end

  def self.search(search)
    if search.present?      
      users = User.or({ :email => /.*#{search}*./ }, { :user_name => /.*#{search}*./ })
      users.where(:role => nil)
    else
      User.where(:role => nil)
    end
  end

  def avatar_url
    if self.avatar.url.nil?
      ""
    else
      if Rails.env.production?
        self.avatar.url
      else
        "http://192.168.0.55:3000" + self.avatar.url.gsub("#{Rails.root.to_s}/public/user/", "/user/")
      end
    end
  end
  
  def self.find_by_token(token)
    User.where(:authentication_token=>token).first
  end  

  def social_state
    if from_social.present?
      from_social.capitalize
    else
      ""
    end
  end
  
  def add_friend(friend)
    user = User.find(self.id)
    ff = user.friends.where(id:friend.id.to_s).first if user.friends.present?
    if ff.present?
      'arleady added friend'
    else
      f_ids = user.friend_ids
      if f_ids.present?
        f_ids+","+friend.id.to_s
      else
        f_ids = friend.id.to_s
      end    
      user.friend_ids = f_ids
      user.save
    end    
  end

  def friends
    if self.friend_ids.present?
      Friend.in(id:self.friend_ids.split(","))
    else
      []
    end
  end

  def my_events_count
    self.events.count
  end

  def attend_events_count
    ad_events = Event.where({ :accepted_friend_ids => /.*#{self.id.to_s}*./ })
    unad_events = Event.where({ :unaccepted_friend_ids => /.*#{self.id.to_s}*./})
    ad_events.count + unad_events.count 
  end

  def approved
    if confirmed_value == 'true'
      return true
    else
      return false
    end
  end

  def send_event_change_notification(event)    
    devices = user.devices
    message = "#{event.name} was changed, please check for that"
    devices.each do |device|
      if device.platform == Device::DEVICE_PLATFORM[0]    # in case platform is ios
        APNS.send_notification(device.dev_id,alert:message, badge:device.badge_count+1, sound: 'default')
      else
        destination = [device.dev_id]
        data = {:alert=>notification.message}
        GCM.send_notification(destination,data)
      end      
    end
  end

  def send_reminder_notification(event)    
    devices = user.devices
    message = "#{event.name} will be start after 10min"
    devices.each do |device|
      if device.platform == Device::DEVICE_PLATFORM[0]    # in case platform is ios
        APNS.send_notification(device.dev_id,alert:message, badge:device.badge_count+1, sound: 'default')
      else
        destination = [device.dev_id]
        data = {:alert=>notification.message}
        GCM.send_notification(destination,data)
      end      
    end
  end
end

class Chat
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :contacted_id,          :type => String

  validates_presence_of :user_id, :contacted_id
  
  belongs_to :user
  belongs_to :event
  
  has_many :notifications

  def contacted_devices
    contact = User.where(id:self.contacted_id).first
    contact.devices if contact.present?
  end

  def send_single_notification(user, contact, msg)
    return false if self.contacted_device.nil? 
    devices = self.contacted_devices
    notification = self.notifications.build(sender_id:user.id.to_s, recver_id:contact.id.to_s, message:msg)
    notification.save
    devices.each do |device|
      if Rails.env.production?
        if device.platform == Device::DEVICE_PLATFORM[0]    # in case platform is ios
          APNS.send_notification(device.dev_id,alert:notification.message, badge:device.badge_count+1, sound: 'default')
        else
          destination = [device.dev_id]
          data = {:alert=>notification.message}
          GCM.send_notification(destination,data)
        end
      end
    end
  end

  def send_multiple_notifications(user, msg, devices)
    notif_ios_dev = []
    notif_android_dev = []    
    notification = self.notifications.build(sender_id:user.id, recver_id:contacted_id, message:msg)
    notification.save
    devices.each do |dev|
      if dev.platform == Device::DEVICE_PLATFORM[0]        
        notif_ios_dev << APNS.Notification.new(dev.dev_id, alert: notification.message, badge:dev.badge_count+1, sound:'default')
      else
        data = {:msg => notification.message}
        options = {:collapse_key => "placer_score_global", :time_to_live => 3600, :delay_while_idle => false}
        notif_android_dev << GCM::Notification.new( dev.dev_id, data, option )
      end
    end
    APNS.send_notifications(notif_ios_dev)
    APNS.send_notifications(notif_android_dev)
  end

  def get_messages(user)
    return [] if self.notifications.blank?    
    messages = []
    self.notifications.each do |notif|
      messages << {id:notif.id.to_s,chat_photo_url:notif.notification_avatar(user),is_my_chat:notif.is_my_message(user),message:notif.message,chat_time:notif.chat_time}
    end
    return messages
  end
  
  def destroy_conversations
    self.notifications.destroy_all
  end
  #handle_asynchronously :send_single_notification, :priority => 20
end

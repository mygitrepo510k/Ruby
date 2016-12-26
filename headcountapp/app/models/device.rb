class Device
  include Mongoid::Document
  include Mongoid::Timestamps

  DEVICE_PLATFORM=%w[ios android]

  field :dev_id,          :type => String  
  field :platform,        :type => String,    default: 'ios'
  field :badge_count,     :type => Integer,   default: 0

  field :enabled_event_message,     :type => Boolean,   default: true
  field :enabled_event_invite,      :type => Boolean,   default: true
  field :enabled_chat_message,      :type => Boolean,   default: true

  belongs_to :user  

  validates_uniqueness_of :dev_id, :scope => :user_id

end

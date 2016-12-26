class Friend
  include Mongoid::Document
  include Mongoid::Timestamps

  SOCIAL_STATE = %w[facebook twitter google]
  mount_uploader :avatar, AvatarUploader

  field :friend_auth_id,    :type => String,  :default => ""
  field :email,             :type => String,  :default => ""
  field :name,					    :type => String
  field :avatar,            :type => String  

  field :from_social,       :type => String

  field :user_ids,          :type => String
  #belongs_to :user
  #belongs_to :event

  validates_presence_of :name, :friend_auth_id
  
  validates_uniqueness_of :friend_auth_id

  def avatar_url
    if self.avatar.url.nil?
      ""
    else
      if Rails.env.production?
        self.avatar.url
      else
        "http://192.168.0.55:3000" + self.avatar.url.gsub("#{Rails.root.to_s}/public/friend/", "/friend/")
      end
    end
  end
  
  def accepted_event(event)
    if event.accepted_friends.include?(self)
      true
    elsif event.unaccepted_friends.include?(self)
      false
    else
      ''
    end
  end
  
  def add_user(user)    
    friend = Friend.find(self.id)
    u_ids = friend.user_ids
    
    uf = friend.users.where(id:user.id.to_s).first if friend.users.present?
    if uf.present?
      "already added user"
    else
      if u_ids.present?
        u_ids+","+user.id.to_s
      else
        u_ids = user.id.to_s
      end    
      friend.user_ids = u_ids
      friend.save
    end
  end

  def device
    user = User.find(self.friend_auth_id)
    if user.present?
      user.devices
    end
  end

  def users
    if self.user_ids.present?
      User.in(id:self.user_ids.split(","))
    else
      []
    end
  end
end

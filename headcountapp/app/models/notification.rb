class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message,					  :type => String

  field :sender_id,					:type => String
  field :recver_id,					:type => String

  belongs_to :chat
  
  def user
  	User.find(sender_id)
  end

  def contact
  	User.find(recver_id)
  end

  def user_photo
  	return '' if user.nil?
  	self.user.avatar_url
  end

  def contact_photo
  	return '' if contact.nil?
  	self.contact.avatar_url
  end

  def notification_avatar(user)
    if is_my_message(user)
      user_photo
    else
      if user.id.to_s == recver_id
        User.find(sender_id).avatar_url
      else
        contact_photo
      end
    end
  end

  def is_my_message(user)
    user.id.to_s == sender_id
  end

  def chat_time
    return created_at
    cur_date = DateTime.now
    duration = (cur_date.to_time-created_at.to_time)
    if duration < 61
      '1 minute ago'
    elsif duration < 3601
      d = duration / 60
      d.to_i.to_s + " minutes ago"
    elsif duration < 86401
      d = duration / 60 / 60
      if d.to_i > 1
        d.to_i.to_s + " hours ago"
      else
        d.to_i.to_s + " hour ago"
      end
    else
      d = duration / 60 / 60 / 24
      if d.to_i > 1
        d.to_i.to_s + " days ago"
      else
        d.to_i.to_s + " day ago"
      end
    end    
  end
end

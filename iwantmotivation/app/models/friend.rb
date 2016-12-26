class Friend < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :channel 
  belongs_to :user, :class_name => "User"
  belongs_to :friend, :class_name => "User"

  validates_presence_of :user_id, :friend_id

  def is_online?    
    self.friend.updated_at>=10.minutes.ago
    #self.friend.logged_in
  end
  def id
    self.friend.id if self.friend.present?
  end
  def email
    self.friend.email if self.friend.present?
  end
  # user infos
  def age
    self.friend.user_info.age
  end
  def city
    self.friend.user_info.city
  end
  def state
    self.friend.user_info.state
  end 
  def country
    self.friend.user_info.country
  end

  def my_story
    self.friend.user_info.my_story
  end
  def philosophy_on_life
    self.friend.user_info.philosophy_on_life
  end
  def motivational_partner
    self.friend.user_info.motivational_partner
  end 
  def books_enjoyed
    self.friend.user_info.books_enjoyed
  end
  def other_groups
    self.friend.user_info.other_groups
  end
  def groups_belong_to
    self.friend.user_info.groups_belong_to
  end
  #users

  def name
    self.friend.name
  end
  def category
    self.friend.category
  end
  def image_url(type)
    self.friend.image_url(type)
  end
  def roles
    self.friend.roles
  end

  def coachcounselor
    self.friend.coachcounselor
  end
  def self.make_friend(user1, user2)
    if user1.created_at > user2.created_at
      channel = user1.name_from_email + "-" + user2.name_from_email
    else
      channel = user2.name_from_email + "-" + user1.name_from_email
    end
    f1 = Friend.where(:user_id => user1.id, :friend_id => user2.id, :channel => "private-" + channel)
    if f1.blank?
      f1=Friend.create
      f1.id=Friend.count
      f1.user_id=user1.id
      f1.friend_id=user2.id
      f1.channel="private-" + channel
      f1.save
    end
    f2 = Friend.where(:user_id => user2.id, :friend_id => user1.id, :channel => "private-" + channel)
    if f2.blank?
      f2=Friend.create
      f2.id=Friend.count
      f2.user_id=user2.id
      f2.friend_id=user1.id
      f2.channel="private-" + channel
      f2.save
    end
    return f1 && f2
  end

  def self.where_or_create(options)
    temp = self.where(options)
    self.create(options) if temp.empty? 
  end 
end

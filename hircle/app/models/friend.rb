class Friend < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :channel 
	belongs_to :user, :class_name => "User"
  belongs_to :friend, :class_name => "User"

	validates_presence_of :user_id, :friend_id

	def self.make_friend(user1, user2)
		if user1.created_at > user2.created_at
			channel = user1.name_from_email + "-" + user2.name_from_email
	    else
	    	channel = user2.name_from_email + "-" + user1.name_from_email

	    end
		f1 = Friend.where_or_create(:user_id => user1.id, :friend_id => user2.id, :channel => "private-" + channel) 
		f2 = Friend.where_or_create(:user_id => user2.id, :friend_id => user1.id, :channel => "private-" + channel) 
		return f1 && f2
	end

	def self.where_or_create(options)
		temp = self.where(options)
		self.create(options) if temp.empty? 
	end
end

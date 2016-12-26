class SocialAuthentication < ActiveRecord::Base
  attr_accessible :uid, :user_name, :user_id, :provider
  
  belongs_to :user
end

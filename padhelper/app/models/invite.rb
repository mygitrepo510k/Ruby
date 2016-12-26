class Invite < ActiveRecord::Base
  attr_accessible :invitee_id, :listing_id, :user_id
end

class Invitation < ActiveRecord::Base
  attr_accessible :email,:invitation_message,:role_id
end

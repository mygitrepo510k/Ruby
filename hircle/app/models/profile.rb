class Profile < ActiveRecord::Base
  attr_accessible :address, :alternate_email, :department_id, :phone, :user_id, :motto
  belongs_to :user
end

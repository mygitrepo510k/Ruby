class UserSetting < ActiveRecord::Base
  attr_accessible :search_city, :search_state, :search_zip_code, :user_id, :time_zone, :account_status, :privacy
  
end

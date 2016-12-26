# == Schema Information
#
# Table name: user_logs
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  likes_viewed_at :datetime
#  views_viewed_at :datetime
#

class UserLog < ActiveRecord::Base
  belongs_to :user
end

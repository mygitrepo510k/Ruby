# == Schema Information
#
# Table name: profile_visits
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProfileVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor, class_name: "User", foreign_key: :viewer_id
  scope :recent, ->(time) { where('profile_visits.created_at >= ?', time) }
end

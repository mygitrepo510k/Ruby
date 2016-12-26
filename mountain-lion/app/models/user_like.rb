# == Schema Information
#
# Table name: user_likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  visitor_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor, class_name: "User", foreign_key: :visitor_id
  scope :recent, ->(time) {where('user_likes.created_at >= ?', time)}
end

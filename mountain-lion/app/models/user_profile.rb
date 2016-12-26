# == Schema Information
#
# Table name: user_profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  about_me    :text
#  looking_for :text
#  created_at  :datetime
#  updated_at  :datetime
#

class UserProfile < ActiveRecord::Base
  belongs_to :user
  def completely_filled?
    UserProfile.where("user_profiles.user_id = ? AND user_profiles.title <>'' AND user_profiles.about_me <>'' AND user_profiles.looking_for <>''", self.user.id).present?
  end
end

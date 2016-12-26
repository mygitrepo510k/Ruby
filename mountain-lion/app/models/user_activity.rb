# == Schema Information
#
# Table name: user_activities
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  activity_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  gender        :string(255)
#

class UserActivity < ActiveRecord::Base
  ACTIVITY_TYPES = %w{ photo_upload profile_update sign_up profile_photo }
  validates :activity_type, inclusion: { in: ACTIVITY_TYPES }
  validates :gender, presence: true, inclusion: { in: ['M', 'F'] }
  scope :by_gender, ->(gender) { where(gender: gender).
                                 joins(:user).
                                 where('users.active = true').
                                 where('users.blocked = false').
                                 where("users.activation_state = 'active'").
                                 order('user_activities.updated_at DESC').
                                 order('users.profile_photo_id IS NULL, users.profile_photo_id DESC').
                                 order('users.rating DESC')}
  scope :staff, -> { includes(:user).
                     joins(:user).
                     where('users.active = true').
                     where('users.blocked = false').
                     where("users.activation_state = 'active'").
                     order('user_activities.updated_at DESC').
                     order('users.profile_photo_id IS NULL, users.profile_photo_id DESC, users.rating DESC').
                     order('users.rating DESC') }
  belongs_to :user
  delegate :user_photos, to: :user
end

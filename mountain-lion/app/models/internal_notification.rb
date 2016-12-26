# == Schema Information
#
# Table name: internal_notifications
#
#  id         :integer          not null, primary key
#  message    :text
#  displayed  :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class InternalNotification < ActiveRecord::Base
  scope :active, -> { where(displayed: true) }
end

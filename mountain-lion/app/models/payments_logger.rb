# == Schema Information
#
# Table name: payments_loggers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#  body       :text
#

class PaymentsLogger < ActiveRecord::Base
  belongs_to :user
end

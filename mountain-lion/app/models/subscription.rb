# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  member_id          :decimal(, )
#  trans_id           :decimal(, )
#  auth_code          :string(255)
#  auth_date          :datetime
#  auth_msg           :string(255)
#  recurring_id       :decimal(, )
#  avs_code           :string(255)
#  cvv2_code          :string(255)
#  settle_amount      :decimal(10, 2)
#  settle_currency    :string(255)
#  processor          :string(255)
#  active             :boolean
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  upgrade_ip_address :string(255)
#

class Subscription < ActiveRecord::Base
  belongs_to :user
end

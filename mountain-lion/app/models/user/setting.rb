# == Schema Information
#
# Table name: user_settings
#
#  id              :integer          not null, primary key
#  messages_email  :boolean          default(TRUE)
#  flirts_email    :boolean          default(TRUE)
#  matches_email   :boolean          default(TRUE)
#  views_email     :boolean          default(TRUE)
#  likes_email     :boolean          default(TRUE)
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  new_users_email :boolean          default(TRUE)
#  unsubscribed    :boolean          default(FALSE)
#

class User::Setting < ActiveRecord::Base
  belongs_to :user
end

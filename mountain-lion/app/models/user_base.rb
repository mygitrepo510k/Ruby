# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  email                           :string(255)      not null
#  date_of_birth                   :date
#  gender                          :string(255)
#  country                         :string(255)
#  zip_code                        :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  activation_state                :string(255)
#  activation_token                :string(255)
#  activation_token_expires_at     :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  failed_logins_count             :integer          default(0)
#  lock_expires_at                 :datetime
#  unlock_token                    :string(255)
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  city                            :string(255)
#  latitude                        :float
#  longitude                       :float
#  firstname                       :string(255)
#  lastname                        :string(255)
#  type                            :string(255)
#  profile_photo_id                :integer
#  rating                          :integer          default(1)
#  last_login_from_ip_address      :string(255)
#  active                          :boolean          default(TRUE)
#  signup_ip_address               :string(255)
#  state                           :string(255)
#  state_id                        :integer
#  city_id                         :integer
#  country_code                    :string(255)
#  unsubscribe_token               :string(255)
#  state_code                      :string(255)
#  blocked                         :boolean          default(FALSE)
#

class UserBase < ActiveRecord::Base
  self.table_name = :users
  authenticates_with_sorcery!
  # validations
  validates :username, presence: true, length: { within: 5..15}, uniqueness: { case_sensitive: false}, format: { with: /\A[a-z0-9]+\z/i }
  validates :email, presence: true, format: { with:  /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i }, uniqueness: { case_sensitive: false }
  validates_confirmation_of :password, on: :create
  before_create :downcase_email

  private
  def downcase_email
    self.email.downcase!
  end
end

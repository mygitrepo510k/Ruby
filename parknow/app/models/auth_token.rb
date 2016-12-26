# == Schema Information
#
# Table name: auth_tokens
#
#  id                   :integer          not null, primary key
#  token                :string
#  device_id            :string
#  device_type          :string
#  user_id               :integer
#  app_type             :string

#  created_at           :datetime
#  updated_at           :datetime

class AuthToken < ActiveRecord::Base
  APP_TYPE_NAME = %w[vendor vendor_user customer admin]  
  attr_accessible :token, :device_id, :device_type, :app_type, :user_id
  validates_presence_of :user_id, :device_id, :device_type, :app_type
  validates_uniqueness_of :token
  validate :app_type_available?, if: :app_type

  belongs_to :user
  before_create :generate_token

  def is_customer?
    self.app_type == APP_TYPE_NAME[2]
  end

  def is_vendor?
    self.app_type == APP_TYPE_NAME[0]
  end

  def is_vendor_user?
    self.app_type == APP_TYPE_NAME[1]
  end

  def is_admin?
    self.app_type == APP_TYPE_NAME[3]
  end

  def customer
    self.user.customer
  end

  def vendor
    self.user.vendor
  end

  def vendor_user
    self.user.vendor_user
  end

  def update_token    
    author = self
    sha_token = Digest::SHA1.hexdigest self.token
    author.token = loop do 
      token = SecureRandom.urlsafe_base64(nil,false)
      sha = Digest::SHA1.hexdigest token
      random_token = "#{sha}-#{token}"
      break random_token unless AuthToken.exists?(token:random_token)
    end
    author.save
    author.token
  end

  protected    
  def generate_token
    self.token = loop do 
      token = SecureRandom.urlsafe_base64(nil,false)
      sha = Digest::SHA1.hexdigest token
      random_token = "#{sha}-#{token}"
      break random_token unless AuthToken.exists?(token:random_token)
    end
  end

  def app_type_available?
    errors.add(:app_type, "please select [vendor, vendor_user, customer]") if !APP_TYPE_NAME.include?(app_type)
  end  
end

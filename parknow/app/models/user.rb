# == Schema Information
#
# Table name: users
#
#  id         					:integer          not null, primary key
#  email                :string
#  password             :string
#  role                 :string

#  created_at 	       :datetime
#  updated_at 	       :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :role

  has_many :auth_tokens
  
  has_one :customer,        dependent: :destroy
  has_one :vendor_user,     dependent: :destroy      
  has_one :vendor,          dependent: :destroy
  
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'  
  belongs_to :invitation

  before_create :set_invitation_limit

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token
    invitation.token if invitation
  end

  def auth_token(device_id)
    device = self.auth_tokens.where(device_id:device_id).first
    if token.present?
      device.token
    else
      nil
    end
  end

  def update_auth_tokens
    self.auth_tokens.each do |author|
      author.token = loop do 
        token = SecureRandom.urlsafe_base64(nil,false)
        sha = Digest::SHA1.hexdigest token
        random_token = "#{sha}-#{token}"
        break random_token unless AuthToken.exists?(token:random_token)
      end
      author.save      
    end
  end

  def self.find_by_token token
    token = AuthToken.where(token:token).first
  	if token.present?
      token.user
    else
      nil
    end
  end 

  def self.create_user(email,password,device_id,device_type,app_type)
    user = User.where(email:email).first
    if user.present?
      device = user.auth_tokens.where(device_id:device_id,app_type:app_type,device_type:device_type)
      if device.present?
        return 'This account was already registered'
      else
        device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:app_type,device_type:device_type)
        return user
      end
    else
      user = User.new(email:email, password:password, password_confirmation:password)
      if user.save
        device = user.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:device_id,app_type:app_type,device_type:device_type)
        return user
      else
        return user.errors.messages 
      end
    end   
  end
  
  private
  def set_invitation_limit
    self.invitation_limit = 10
  end  
end

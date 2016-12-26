class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  MEMBER_AMOUNT = {:full=>"9.5", :limited=>"4.95", :coach=>"19.5", :counselor=>"19.5"}

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :logged_in, :stripe_token, :coupon, :amount, :payment_token, :transaction_cleared, :identifier, 
                  :foundus_id, :category_id, :user_option_id, :ismember, :login,
                  :pictures_attributes, :user_info_attributes, :coachcounselor_attributes, 
                  :user_categories_attributes
  attr_accessor :stripe_token, :coupon, :login
  
  #before_save :update_stripe
  #before_destroy :cancel_subscription

  belongs_to :foundus  
  belongs_to :user_option

  has_many :user_categories
  has_many :categories, :through => :user_categories

  has_many :pictures, :as => :imageable, :dependent => :destroy

  has_one :user_info, :dependent => :destroy  
  has_one :coachcounselor, :dependent => :destroy

  accepts_nested_attributes_for :user_info, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :pictures, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :coachcounselor, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :user_categories, :allow_destroy=>true, :reject_if => :all_blank

  scope :online, lambda { where('updated_at >= ?', 5.minutes.ago).order('created_at desc')}
  
  scope :members, :conditions => ["ismember = '1'"]
  scope :cmembers, :conditions => ["ismember = '0'"]
  
  has_many :friends
  has_many :invitees, :class_name => self.name, :as => :invited_by
  
  has_many :member_groups
  has_many :groups, :through => :member_groups

  has_many :invites
  has_many :invited_groups, :through => :invites, :class_name => "Group"

  #validates_uniqueness_of :name
  #validates_associated :user_info

  after_invitation_accepted :email_invited_by

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def email_invited_by
    
  end

  def channel
    return "null-channel"
  end
  def really_name
    self.coachcounselor.really_name
  end
  def mail_count
    self.mailbox.inbox.count
  end
  def image_url(type)
    self.pictures.last.image.url(type) unless self.pictures.last.nil?
  end
  def age
    self.user_info.age
  end
  def city
    self.user_info.city
  end
  def state
    self.user_info.state
  end
  def country
    self.user_info.country
  end
  
  def my_story
    self.user_info.my_story
  end
  def philosophy_on_life
    self.user_info.philosophy_on_life
  end
  def motivational_partner
    self.user_info.motivational_partner
  end 
  def books_enjoyed
    self.user_info.books_enjoyed
  end
  def other_groups
    self.user_info.other_groups
  end
  def groups_belong_to
    self.user_info.groups_belong_to
  end

  def role
    self.roles.last.name
  end
  def is_admin?
    return self.roles.find_by_name "admin"
  end
  def is_online?
    self.updated_at>=3.minutes.ago
  end
  
  def is_friend(friend)
    f=Friend.where(:user_id => self.id, :friend_id => friend.id).first
    f.present?    
  end
  
  def friend(friend)
    Friend.where(:user_id => self.id, :friend_id => friend.id).first
  end

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end
  def set_payment token, amount,transaction
    self.payment_token = token
    self.amount = amount
    self.transaction_cleared = transaction
  end
  def update_stripe
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => roles.first.name
        )
      else
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => roles.first.name,
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end
  
  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end
  def name_from_email 
    email.split('@')[0].gsub(/[^a-z ^0-9]/, '-') 
  end

  acts_as_messageable
  def mailboxer_email(message)
    email
  end
end

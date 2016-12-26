# @author: Hammad Siddiqui

class User < ActiveRecord::Base
  has_paper_trail
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :refill_reminder, :expire_reminder
  attr_accessible :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at,
                  :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :profile_updated, :invitation_token
  # attr_accessible :title, :body

  has_one :profile
  has_one :payment_profile
  has_one :linked_doctor, class_name: "Doctor"
  has_one :notification_settings

  has_many :notifications
  has_many :prescriptions
  has_many :doctor_patients
  has_many :doctors, :through => :doctor_patients
  has_many :orders

  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :profile, :linked_doctor

  after_create :welcome_notification
  after_create :update_user_ids_for_associations, if: 'self.invitation_token'

  scope :patients, joins(:roles).where(roles: { name: 'patient' })

  # Needed when registering invited user that followed email link
  attr_accessor :invitation_token

  # Checks whether a user exists in a given role
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  # first_name and last_name specific search for pateints type users
  #
  # @param [String] search the search term
  # @return (Array<User>)
  def self.search_patients(search)
    search_condition = "%" + search + "%"
    User.find(:all, :joins => [:profile], :conditions => ['profiles.first_name LIKE ? OR profiles.last_name LIKE ?', search_condition, search_condition], :select => "first_name, last_name" )
  end

  def to_s
    self.email
  end

  def name
    name = self.email

    if self.profile.present? and self.profile.name.present?
      name = self.profile.name
    end

    name
  end

  def profile
    @profile   = Profile.find_by_user_id(self.id)
    @profile ||= Profile.new(:user_id => self.id)
  end

  # Adds specified role if she's allowed in Role::PUBLIC
  #
  # @param [String] role desired role. Can be nil.
  def set_role(role)
    final_role = (role && Role::PUBLIC.include?(role)) ? role : Role::DEFAULT
    self.roles << Role.find_by_name(final_role)
  end

  # Gag that returns current user role. Should be used instead of roles.first.
  # @return [Role]
  def current_role
    self.roles.first
  end

  private

  # Updates user_id for associated DoctorPatients, Prescriptions(indirectly)
  def update_user_ids_for_associations
    doctor_patient = DoctorPatient.where(invitation_token: self.invitation_token).first
    doctor_patient.update_attributes(user_id: self.id, status: :active)
    doctor_patient.prescription.update_attribute(:user_id, self.id)
  end

  # Adds welcome notification for all public users
  def welcome_notification
    notification = Notification.new(:notification_type => :welcome, :parameters => {:sender_name => "Medijean"})
    notification.user = self
    notification.save
  end
end

# This model reresents the doctor-patient relationship.
#
# When a doctor adds ("tags") a patient, they're added to the "tagged" state
# When a doctor actually prescribes to a patient, they are sent an email invitation and this record is moved to the "invited" state
# When a patient logs in and confirms, the record is converted to the "active" state
class DoctorPatient < ActiveRecord::Base
  enum_field :status, { tagged:0, invited: 1, active: 2 }

  attr_accessible :status, :user_id, :email, :prescription_id, :health_card_number

  belongs_to :doctor
  belongs_to :user
  has_one :prescription

  validates_presence_of :doctor, :status
  validates_presence_of :prescription, :if => :invited?
  validates_presence_of :user, :if => :active?
  validates_presence_of :health_card_number

  validates_uniqueness_of :email, scope: :doctor_id

  validate :user_or_email
  validate :health_card_numbers_match, unless: 'self.user_id.nil?'

  scope :invited, where(status: 1)

  before_validation :assign_user, on: :create

  def assign_user
    existing_user = User.patients.where(email: self.email).first
    self.user_id  = existing_user.id if existing_user
  end

  def active?
    self.status?(:active)
  end

  def invited?
    self.status?(:invited)
  end

  # @return [String] name from profile in case user is active
  def name
    active? ? user.profile.name : email
  end

  # @return [String] health card number from profile in case user is active
  def actual_health_card_number
    active? ? user.profile.health_card_number : self.health_card_number
  end

  # sends invitation token
  def send_invitation
    if generate_invitation!
      InvitationsMailer.patient_invitation(self.doctor_id, self.id).deliver!
      self.update_attribute(:status, :invited)
    end
  end

  # generates and saves invitation token
  # @return [Boolean] success\failure of save attempt
  def generate_invitation!
    self.invitation_token = Digest::MD5.hexdigest("#{self.doctor.id.to_s + rand(999999).to_s}")
    save
  end

  private

  def health_card_numbers_match
    if self.user.try(:profile).try(:health_card_number) != self.health_card_number
      errors[:health_card_number] << I18n.t('activerecord.errors.models.doctor_patient.attributes.health_card_number.not_matches')
    end
  end

  def user_or_email
    errors[:base] << "user or email needs to be specified to tag a user" if self.user.nil? and self.email.nil?
  end
end

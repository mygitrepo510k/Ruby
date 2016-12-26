# This model represents doctor's profile in the database
class Doctor < ActiveRecord::Base
  has_paper_trail

  enum_field :status, { inactive: 0, active: 1 }
  enum_field :gender, { male: 0, female: 1 }

  attr_accessible :first_name, :last_name, :photo, :gender, :phone, :email, :website, :fax, :physician_id, :user_id, :speciality, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :clinic_id

  has_many :doctor_patients
  has_many :patients, through: :doctor_patients, source: :users
  has_one :address, as: :addressable

  belongs_to :clinic
  belongs_to :user

  validates :first_name, :last_name, :clinic, :physician_id, presence: true, allow_blank: false, if: :active?
  validates_uniqueness_of :physician_id

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  scope :not_registered, where(user_id: nil)

  # This method will search doctors by first name and last name fields.
  # todo search conditions will be change. In future patients can find the doctor by phone number, clinical information, etc..
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE ?', search_condition, search_condition])
  end

  def self.find_or_create(attributes)
    Doctor.where(attributes).first || Doctor.create(attributes)
  end

  def self.build_from(params)
    clinic = params.delete(:clinic)
    doctor = new(params)
    doctor.set_clinic(clinic)
    doctor
  end

  def to_s
    return "#{self.first_name} #{self.last_name}" if self.first_name.present?
    self.email
  end

  def active?
    self.status?(:active)
  end

  def name
    return "#{first_name} #{last_name}" if self.first_name.present? and self.last_name.present?
    return "Dr. #{last_name}" if self.last_name.present?
    return self.first_name if self.first_name.present?
    return self.email if self.email.present?
    self.user.email if self.user.present?
  end

  # Sets association with existent or new clinic
  # @param [Hash] params clinic attributes
  def set_clinic(params)
    self.clinic = Clinic.find_by_phone(params[:phone]) || Clinic.new(params)
  end

  after_initialize :default_values

  private
  def default_values
    # TODO: Temporary, until 3.5-3.7(doctor status confirmation) implemented. Don't forget to comment it before adding real data!
    self.status ||= :active
  end
end
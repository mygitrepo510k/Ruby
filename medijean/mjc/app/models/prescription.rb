class Prescription < ActiveRecord::Base
  has_paper_trail
  REFILL_BUFFER = 14.days

  enum_field :administration_method, { vaporization: 0, combustion: 1, edibles: 2, topical: 3 }
  enum_field :status, { uploaded: 0, prescribed: 1, approved: 2, active: 3, ordered: 4 }

  # Constants
  SYMPTOMS           = ["Epilepsy", "Alcoholism", "Cancer", "Glaucoma", "AIDS", "Anxiety, Depression or Obsession", "Suppression of nausea", "Reduction in interlobular pressure inside the eye", "Relief of chronic pain", "Relief of muscle spasms", "Multiple Sclerosis", "Spinal Cord Injuries", "Alzheimer disease", "Breast cancer", "Opioid dependence", "Controlling ALS symptoms", "Crohn Disease", "Diabetes", "Hepatitis C", "Arthritis", "Inflammation", "Fibromyalgia", "Migraines", "Parkinson disease", "Depression Post traumatic stress disorder (PTSD)", "Cerebral palsy", "Anxiety", "Other"]
  USAGE_HABITS       = ["Chronic user", "Occasional user", "Non-user", "Never used"]
  ADMINISTRATION_METHODS  =  ["vaporization", "combustion","edibles", "topical"]
  DOSAGES            = ["1g/day", "2g/day","3g/day", "4g/day", "5g/day", "Other"]

  # @note doctor_name attribute defined for when patient user manual upload its prescription.
  # issue_date attribute user for prescription issue date and expiration attribute used for expiry date.
  attr_accessible :description, :symptom, :prescription_image, :dosage, :status, :medicine, :issue_date, :doctor_name, :user_id, :current_usage_habits, :doctor_id, :expiration, :medicine_id, :administration_method, :other_symptom
  attr_accessible :prescription_image_file_name, :prescription_image_content_type, :prescription_image_file_size, :prescription_image_updated_at, :doctor_patient_id

  has_attached_file :prescription_image, styles: { thumb: "150x150>" }

  attr_accessor :other_dosage

  belongs_to :doctor_patient
  belongs_to :user
  belongs_to :dosage
  belongs_to :medicine
  belongs_to :doctor

  validates_attachment_presence :prescription_image, if: :uploaded?

  validates_presence_of :user, unless: 'self.status == :prescribed'
  validates_presence_of :status, :symptom, :medicine_id
  validates_presence_of :administration_method, :expiration, :dosage, :doctor, if: :active?
  validates_presence_of :description, :current_usage_habits, :doctor_name, :issue_date, :expiration, if: :uploaded?

  def to_s
    self.medicine.to_s
  end

  after_create :send_invitation, if: 'self.status == :prescribed and self.user.nil?'
  after_create :new_prescription_notification_to_patient, if: :prescribed?

  # Builds Prescription instance from provided Hash of attributes
  # @param [Hash] attributes for Prescription
  # @return [Prescription] not saved Prescription instance
  def self.build_from(params)
    quantity             = params.delete('other_dosage') || params.delete('dosage')
    doctor_patient       = DoctorPatient.where(id: params['doctor_patient_id']).first
    dosage               = Dosage.new(quantity: quantity, unit: :grams, frequency: :daily)
    prescription         = new(params.merge(status: 'prescribed'))
    prescription.user_id = doctor_patient.user_id if doctor_patient.try(:user)
    prescription.dosage  = dosage
    prescription
  end

  %w(uploaded active prescribed approved ordered).each do |method_name|
    define_method(method_name + '?') do
      self.status?(method_name)
    end
  end

  def prescribing_doctor
    return "Dr. #{doctor_name}" if self.doctor_name.present?
    return "Dr. #{self.doctor.name}" if self.doctor.present?
  end

  def send_invitation
    self.doctor_patient.send_invitation
  end

  def prescription_symptom
    return other_symptom if self.symptom == "Other"
    return self.symptom
  end

  def new_prescription_notification_to_patient
    notification = Notification.new(:notification_type => :incoming_prescription, :parameters => {:sender_name => self.prescribing_doctor})
    notification.user = self.user
    notification.save
  end

end
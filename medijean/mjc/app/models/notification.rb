# Represents a notification that is sent to the user
#
# @attr [User] user the user being notified
# @attr [Integer] notification_type the type of the notification
# @attr [Hash] parameters the parameters of the notification
class Notification < ActiveRecord::Base
  attr_accessible :parameters, :read, :notification_type, :user_id, :url
  
  enum_field :notification_type, { welcome: 0, incoming_prescription: 1, prescription_expiration: 2, patient_tagged: 3 } # add more as needed

  belongs_to :user
  serialize :parameters
  validate :validate_parameters

  validates_presence_of  :notification_type, :user
  validates :read, :inclusion => {:in => [true, false]}

  # scopes 
  scope :unviewed, where(:read => false)
  scope :viewed, where(:read => true)
  default_scope order('created_at DESC')


  after_initialize :default_values

  private
  def validate_parameters
    if self.notification_type.present?
      string = I18n.t(:"notifications.#{self.notification_type}") 
      required_parameters = string.scan(/{(.*?)}/).flatten.map { |k| k.to_sym }

      required_parameters.each do |parameter|
        errors.add("parameters", "doesn't include :#{parameter}, required for :#{self.notification_type} notification") if !self.parameters.present? || !self.parameters.has_key?(parameter)
      end
    end
  end

  def default_values
    self.read = false if self.read.nil?
  end

end

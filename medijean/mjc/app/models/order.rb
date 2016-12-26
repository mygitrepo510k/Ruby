# Represents an order placed by a user
class Order < ActiveRecord::Base
  has_paper_trail
  DEFAULT_TAX_NAME = "HST"
  DEFAULT_TAX_RATE= 0.13

  enum_field :status, { placed: 0, processing: 1, shipped: 2, received: 3 }
  enum_field :payment_status, { none: 0, captured: 1, charged: 2, refunded: 3 }
  attr_accessible :placed_at, :status, :total, :sub_total, :tax, :taxname, :prescription_id, :payment_status, :user, :prescription, :line_items, :shipping_address,:user_id, :shipping_address_id, :tracking_number

  #attr_accessor :stripe_card_token

  belongs_to :shipping_address, :class_name => "Address"
  belongs_to :user
  belongs_to :prescription
  belongs_to :processed_by, :class_name => "AdminUser"

  has_many :payments
  has_many :line_items

  after_initialize :default_values
  before_validation :ensure_immutable_objects

  validates_presence_of :total, :status, :placed_at, :sub_total, :tax, :taxname, :shipping_address, :payment_status, :prescription_id, :user
  validates_presence_of :tracking_number, :if => :is_processing?
  validate :custom_validations
  validates :line_items, :length => { :minimum => 1 }

  def to_s
    "#{placed_at}, #{status}, #{total}"
  end

  def is_processing?
    self.status?(:shipped)
  end

  private
  def default_values
    self.taxname ||= DEFAULT_TAX_NAME
    self.payment_status ||= :none
    self.tax ||= DEFAULT_TAX_RATE
  end

  def ensure_immutable_objects
    if self.shipping_address.present? and !self.shipping_address.immutable
      self.shipping_address.immutable = true
      self.shipping_address = Address.find_or_create(self.shipping_address.attributes.except("id", "updated_at", "created_at"))
    end
  end

  def custom_validations
    errors.add("shipping_address", "has to be an immutable copy of the address") if self.shipping_address and !self.shipping_address.immutable
    errors[:base] << "a user can only order their own prescriptions" if self.prescription.present? and self.user != self.prescription.user
  end

end
class Address < ActiveRecord::Base
  #  The postcode formatting and validation methods.
  include GoingPostal
  has_paper_trail

  has_many :orders, :foreign_key => "shipping_address"

  belongs_to :country
  belongs_to :addressable, polymorphic: true

  attr_accessible :city, :country_id, :postal_code, :province, :street, :unit, :immutable, :addressable_id, :addressable_type

  validates_presence_of :country, :city, :street
  validate :canadian_postal_code

  after_initialize :default_values

  before_save :check_immutability

  def self.find_or_create(attributes)
    Address.where(attributes).first || Address.create(attributes)
  end

  # this function validate's the canadian postal codes.
  def canadian_postal_code
    if postal_code.present?
      errors.add(:postal_code, "not a valid Canadian postal code") unless GoingPostal.postcode?(postal_code, "CA")
    end
  end

  def to_s
    return "#{street}, #{city}, #{province} #{postal_code}" if self.street.present?
    return "#{city}, #{province} #{postal_code}" if self.street.blank?
  end

  def full_address
    str = "#{street}, #{city}, #{country.code}"
    self.postal_code ? str + ", #{postal_code}" : str
  end

  def self.full_address_to_hash(full_addr)
    hash               = {}
    arr                = full_addr.gsub(' ', '').split(',')
    hash[:street]      = arr[0]
    hash[:city]        = arr[1]
    hash[:country_id]  = Country.find_by_code(arr[2]).try(:id)
    hash[:postal_code] = arr[3] if arr[3]
    hash
  end

  private
  def default_values
    self.country ||= Country.find_or_create_by_name_and_code("Canada", "CA")
    self.immutable = false if self.immutable.nil?
  end

  def check_immutability
    raise ActiveRecord::ReadOnlyRecord if self.immutable and !new_record?
  end
  
end
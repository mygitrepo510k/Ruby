class Clinic < ActiveRecord::Base

  has_many :doctors
  has_one :address, as: :addressable

  attr_accessible :name, :phone, :website, :address_attributes

  validates_presence_of :phone, :address

  accepts_nested_attributes_for :address

  def set_address(params)
    params = Address.full_address_to_hash(params[:full_address]) if params[:full_address]
    self.address = Address.find_or_create(params)
    save
  rescue ActiveRecord::RecordNotSaved
    return false
  end
end
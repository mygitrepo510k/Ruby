class LineItem < ActiveRecord::Base
  attr_accessible :medicine_id, :price, :quantity, :unit

  enum_field :unit, { grams: 0, units: 1 }

  validates_presence_of :unit, :quantity, :medicine, :price

  belongs_to :order
  belongs_to :medicine

  validate :validate_price

  private
  def validate_price
    errors.add("unit", "should be the same as what's defined for medicine") if self.medicine.present? and self.medicine.unit != self.unit    
    errors.add("price", "not equal to calculated value") if self.medicine.present? and self.price != self.quantity * self.medicine.price
  end
end

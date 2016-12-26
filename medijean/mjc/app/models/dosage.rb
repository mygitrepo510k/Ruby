class Dosage < ActiveRecord::Base
  enum_field :frequency, { daily: 0, weekly: 1, monthly: 2, yearly: 3 }
  enum_field :unit, { units: 0, grams: 1 }

  attr_accessible :frequency, :quantity, :unit

  validates_presence_of :frequency, :quantity, :unit

  def self.find_or_create(attributes)
    Dosage.where(attributes).first || Dosage.create(attributes)
  end
end

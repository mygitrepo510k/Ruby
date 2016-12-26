class Medicine < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name, :price, :unit

  enum_field :unit, { grams: 0, units: 1 }

  validates_presence_of :name, :price, :unit

  def to_s
    return "#{name}"
  end

  after_initialize :default_values

  private
  def default_values
    self.unit ||= :grams
  end
end

class CanadianPostalCodeValidator
  include GoingPostal

  def initialize(address)
    @address = address
  end

  def validate
    if @address.postal_code.present?
      @address.errors[:base] << "not a valid Canadian postal code." unless GoingPostal.postcode?(@address.postal_code, "CA")
    end
  end
end

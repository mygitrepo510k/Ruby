class Payment
  include ActiveModel::Model


  attr_accessor :first_name,
                :last_name,
                :address,
                :zip_code,
                :country_code,
                :credit_card_type,
                :credit_card_number,
                :expiry_month,
                :expiry_year,
                :security_code,
                :email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :country_code, presence: true
  validates :credit_card_number, presence: true
  validates :expiry_month, presence: true
  validates :expiry_year, presence: true
  validates :security_code, presence: true
  validates :email, presence: true

  def initialize(user, params = nil)
    if params.present?
      params.each { |key, val|  self.send("#{key}=",val) }
    else
      new_without_params(user)
    end
  end

  def new_without_params(user)
    @first_name = user.firstname
    @last_name = user.lastname
    @zip_code = user.zip_code
    @country_code = user.country_code
    @email = user.email
  end

  def card_expire
    "#{'%02d' % expiry_month}#{expiry_year[-2,2]}"
  end
end



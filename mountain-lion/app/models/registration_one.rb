class RegistrationOne
  include ActiveModel::Model
  attr_accessor :gender, :email, :password, :date_of_birth, :username

  validates :gender, presence: true, inclusion: { in: ['M', 'F'] }
  validates :email, presence: true, format: { with:  /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i },
    confirmation: true
  validates :date_of_birth, presence: true
  validate :check_email_uniqueness
  validate :user_of_legal_age
  validates :username, presence: true, length: { within: 5..15},
    format: { with: /\A[a-z0-9]+\z/i, message: "Please enter numbers or letters only" }
  validate :check_username_uniqueness
  validate :check_forbidden_usernames

  def initialize(args = nil)
    if args
      args.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end

  private
  def check_email_uniqueness
    if email.present? && UserBase.where(email: email.downcase).count > 0
      errors[:email] << 'This email is already registered.'
    end
  end

  def user_of_legal_age
    if date_of_birth.present? && Date.strptime(date_of_birth,'%m/%d/%Y').to_date > 18.years.ago.to_date
      errors[:date_of_birth] << "You must be older than 18 to sign up."
    end
  rescue
      errors[:date_of_birth] << "Invalid date format, please try again."
  end

  def check_username_uniqueness
    if username.present? && UserBase.where(username: username.downcase).count > 0
      errors[:username] << 'This username is already registered.'
    end
  end

  def check_forbidden_usernames
    if username.present? && User::FORBIDDEN_USERNAMES.select { |u| username =~ /#{u}/i }.count > 0
      errors[:username] << 'This username is not permitted!'
    end
  end
end

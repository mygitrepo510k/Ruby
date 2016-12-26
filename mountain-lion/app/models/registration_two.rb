class RegistrationTwo
  include ActiveModel::Model
  attr_accessor :gender, :email, :password, :date_of_birth,
    :username, :firstname, :lastname, :country_code, :zip_code, :city, :ip_address

  validates :country_code, presence: true
  validates :zip_code, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :password, presence: true, confirmation: true

  def initialize(args = nil)
    if args
      args.each do |key, value|
        self.send("#{key}=", value)
      end
    end
    @country_code ||= 'us'
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    user = User.create!(date_of_birth: Date.strptime(date_of_birth,'%m/%d/%Y'),
                email: email, gender: gender, password: password,
                username: username, firstname: firstname, lastname: lastname,
                country: country, city: city, zip_code: zip_code,
                signup_ip_address: ip_address, country_code: country_code,
                unsubscribe_token: TokenGenerator.generate_random_token)
    user.setting = User::Setting.create!
    user.geocode
    user.save
    user.user_activity = UserActivity.create!(activity_type: 'sign_up', gender: gender)
    user.user_profile = UserProfile.create!
    user.user_log = UserLog.create!(likes_viewed_at: Time.now, views_viewed_at: Time.now)
    send_welcome_message(user)
  end

  def send_welcome_message(user)
    support = User.find(-1)
    support.sent_messages.create!(recipient: user,
      subject: 'Welcome to HyeDating.com',
      body: "Welcome to HyeDating.com...  The new hotspot for dating within the Armenian Community.\n\n\n      Here's a brief overview of how things work here...  This is your inbox where you will receive your messages and flirts from other members.  The lounge is where you will be notified of new members, birthdays, new photos, or any updates to a particular members photos.  Who likes you are any members who clicked the \"like\" button your profile.  Who you like is a collection of all the members who's profiles you've liked.  Who looked at you is a list of all the members who have viewed your profile.  Your matches are any profiles with which you have anything in common.  You may also search for members near you using our proximity search located in the right column of your screen.\n\n\n      If you have any questions, the help section should answer most all your questions.  If you need further assistance, please email us at support@hyedating.com.\n\n\n      Thank you and Good Luck!\n\n\n      HyeDating.com Staff")
  end

  def country
    Country.find_by_code(country_code.upcase).name
  end
end

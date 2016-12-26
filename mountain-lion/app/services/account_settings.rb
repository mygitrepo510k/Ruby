class AccountSettings
  include ActiveModel::Model

  attr_accessor :password, :old_password, :receives_messages,
    :receives_flirts, :receives_matches, :receives_likes, :receives_views,
    :username, :firstname, :lastname, :date_of_birth, :gender,
    :country_code, :city, :receives_new_users

  attr_reader :user

  validates :gender, presence: true, inclusion: { in: ['M', 'F'] }
  validates :password, presence: true, confirmation: true, if: Proc.new { |r| r.old_password.present? }
  validates :username, presence: true, length: { within: 5..15},
    format: { with: /\A[a-z0-9]+\z/i, message: "Please enter numbers or letters only" }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :country_code, presence: true
  validates :city, presence: true
  validate :check_username_uniqueness
  validate :check_forbidden_usernames

  def initialize(user, args = nil)
    @user = user
    if args.present?
      args.each do |key, value|
        self.send("#{key}=", value)
      end
      @date_of_birth = Date.strptime(date_of_birth, '%m/%d/%Y')
    else
      @username = user.username
      @firstname = user.firstname
      @lastname = user.lastname
      @date_of_birth = user.date_of_birth
      @gender = user.gender
      @receives_messages = setting.messages_email
      @receives_likes = setting.likes_email
      @receives_flirts = setting.flirts_email
      @receives_matches = setting.matches_email
      @receives_views = setting.views_email
      @receives_new_users = setting.new_users_email
      @country_code = user.country_code
      @city = user.city
    end
  end

  def save
    valid_password?
    if valid?
      persist!
      true
    else
      false
    end
  end

  private
  def persist!
    if old_password.present?
      user.change_password!(password)
    end
    changed_gender = user.gender != gender
    user.update_attributes!(username: username,
                            firstname: firstname,
                            lastname: lastname,
                            date_of_birth: date_of_birth,
                            gender: gender,
                            country: country,
                            country_code: country_code,
                            city: city)
    user.setting.update_attributes!(likes_email: receives_likes,
                                   matches_email: receives_matches,
                                   flirts_email: receives_flirts,
                                   messages_email: receives_messages,
                                   views_email: receives_views,
                                   new_users_email: receives_new_users)
    if user.setting.unsubscribed && notification_settings_changed?
        user.setting.update_attribute(:unsubscribed, false)
    end
    user.user_activity.update_attribute(:gender, gender)
  end

  def notification_settings_changed?
      [
        receives_messages,
        receives_flirts,
        receives_matches,
        receives_likes,
        receives_views,
        receives_new_users
      ].reject { |x| x.to_i == 0 }.count > 0
  end
  def valid_password?
    if old_password.present?
      if UserBase.authenticate(user.username, old_password)
        true
      else
        errors.add(:old_password, 'Your password is incorrect, please enter the right password')
        false
      end
    end
  end

  def setting
    user.setting
  end

  def check_username_uniqueness
    if username.present? && username != user.username && UserBase.where('lower(username) = ? ', username.downcase).count > 0
      errors[:username] << 'This username is already registered.'
    end
  end

  def check_forbidden_usernames
    if username.present? && User::FORBIDDEN_USERNAMES.include?(username.downcase)
      errors[:username] << 'This username is not permitted!'
    end
  end

  def country
    Country.find_by_code(country_code.upcase).name
  end
end

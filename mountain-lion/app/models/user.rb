# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  email                           :string(255)      not null
#  date_of_birth                   :date
#  gender                          :string(255)
#  country                         :string(255)
#  zip_code                        :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  activation_state                :string(255)
#  activation_token                :string(255)
#  activation_token_expires_at     :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  failed_logins_count             :integer          default(0)
#  lock_expires_at                 :datetime
#  unlock_token                    :string(255)
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  city                            :string(255)
#  latitude                        :float
#  longitude                       :float
#  firstname                       :string(255)
#  lastname                        :string(255)
#  type                            :string(255)
#  profile_photo_id                :integer
#  rating                          :integer          default(1)
#  last_login_from_ip_address      :string(255)
#  active                          :boolean          default(TRUE)
#  signup_ip_address               :string(255)
#  state                           :string(255)
#  state_id                        :integer
#  city_id                         :integer
#  country_code                    :string(255)
#  unsubscribe_token               :string(255)
#  state_code                      :string(255)
#  blocked                         :boolean          default(FALSE)
#

class User < UserBase
  geocoded_by :geo_data
  FORBIDDEN_USERNAMES = %w{
    admin hyedating webmaster support administrator searchsingles postmaster message messages messaging contact domain email
  }
  REQUIRED_PROFILE_SECTIONS = ["My Description"]
  OPTIONAL_PROFILE_SECTIONS = ["Personality", "Interests", "Outlook", "Facts about me"]

  scope :by_gender, ->(gender) { where(gender: gender).includes([:user_questions, :user_photos, :user_activity]) }
  scope :seo_gender, ->(gender) { active.where(gender: gender).includes(:user_profile).order('created_at DESC') }
  scope :active, -> { where(active: true).where(activation_state: "active").where(blocked: false) }
  
  has_many :user_questions, dependent: :destroy
  has_one :user_activity, dependent: :destroy
  has_one :user_profile, dependent: :destroy
  has_one :user_log, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :setting, class_name: 'User::Setting', dependent: :destroy
  has_many :user_photos, dependent: :destroy
  has_many :profile_visits, class_name: "ProfileVisit", foreign_key: :user_id, dependent: :destroy
  has_many :visited_profiles, class_name: "ProfileVisit", foreign_key: :viewer_id, dependent: :destroy
  has_many :user_likes, class_name: "UserLike", foreign_key: :user_id, dependent: :destroy
  has_many :liked_users, class_name: "UserLike", foreign_key: :visitor_id, dependent: :destroy
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id, dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id, dependent: :destroy
  accepts_nested_attributes_for :user_profile
  # fixing gender change issues
  after_save :update_gender

  def profile_sections
    # this method is bad on so many levels
    section_ids = user_questions.includes(:profile_question).map {|uq| uq.profile_question.profile_section_id if uq.profile_question }.uniq
    ProfileSection.where(id: section_ids)
  end
  def required_profile_sections
    ProfileSection.where(name: REQUIRED_PROFILE_SECTIONS)
  end
  def optional_profile_sections
    ProfileSection.where(name: OPTIONAL_PROFILE_SECTIONS)
  end
  def required_profile_question_ids
    @id_arr = []
    required_profile_sections.each do |rp|
      @id_arr = rp.profile_questions.collect { |r| r.id }
    end
    @id_arr.flatten
  end
  def required_user_questions_complete?
    uqs = UserQuestion.where(profile_question_id: required_profile_question_ids, user_id: self.id)
    rq_flag = true
    uqs.each do |uq|
      rq_flag = rq_flag && uq.answer.present?
    end
    rq_flag
  end
  def required_user_fields_complete?
    required_user_questions_complete? && user_profile.completely_filled?
  end
  def profile_questions(profile_section)
    user_questions.joins(:profile_question).where('profile_questions.profile_section_id = ?', profile_section)
  end
  def log_activity(type)
    self.save
    user_activity.update_attributes(activity_type: type, gender: self.gender, updated_at: Time.now)
  end
  def geo_data
    [zip_code, city, country].compact.join(', ')
  end
  def unread_messages
    received_messages.unread
  end
  def unread_message_count
    unread_messages.count
  end
  def visit_profile(other)
    visited_profiles.find_or_create_by_user_id(other.id)
  end
  def recent_visitors
    profile_visits.
      recent(user_log.views_viewed_at).
      joins(:visitor).
      where('users.blocked = false').
      count
  end
  def recent_likes
    user_likes.
      recent(user_log.likes_viewed_at).
      joins(:visitor).
      where('users.blocked = false').
      count
  end
  def write_log(what)
    case what
    when "likes"
      user_log.likes_viewed_at = Time.now.utc
    when "views"
      user_log.views_viewed_at = Time.now.utc
    end
    user_log.save
  end
  def manage_like(other)
    if liked_user_ids.include?(other.id)
      liked_users.where(user_id: other.id).first.destroy
    else
      liked_users.find_or_create_by_user_id(other.id)
      Thread.new do
        UserMailer.profile_like_email(self, other).deliver
      end
    end
  end
  def liked_user_ids
    liked_users.map { |lu| lu.user_id }
  end
  def profile_photo(own_photo = false)
    if own_photo
      user_photos.where(id: self.profile_photo_id).first
    else
      user_photos.approved.where(id: self.profile_photo_id).first
    end
  end
  def profile_photo=(user_photo)
    update_attribute(:profile_photo_id, user_photo.id)
  end
  def display_username
    "@#{username}"
  end
  def premium?
    subscription.present? && subscription.active
  end
  alias_method :premium, :premium?

  def premium=(value)
    if subscription.present?
      self.subscription.update_attribute(:active, value == "1")
    else
      self.subscription = Subscription.create!(active: value == "1")
    end
  end
  def update_gender
    user_activity.update_attribute(:gender, self.gender)
  rescue
  end

  def unsubscribe_all
    setting.update_attributes(messages_email: false, flirts_email: false, matches_email: false, views_email: false, likes_email: false, new_users_email: false, unsubscribed: true)
    self.update_attribute(:unsubscribe_token, TokenGenerator.generate_random_token)
  end

  def block!
    self.update_column(:blocked, true)
  end

  def unblock!
    self.update_column(:blocked, false)
  end
end

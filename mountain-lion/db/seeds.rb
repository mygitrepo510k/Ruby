# Creating the admin user
u = Admin.create(username: "admin", email: "admin@example.com", password: "HyePassword", password_confirmation: "HyePassword")
u.activate!

# Creating the Profile Sections
ProfileSection.destroy_all
ProfileQuestion.destroy_all
ProfileAnswer.destroy_all
json = JSON.parse(File.read(Rails.root + 'db/profile.json'))
json["profile_sections"].each do |profile_section|
  ps = ProfileSection.create(name: profile_section["name"], displayed: profile_section["displayed"])
  profile_section["profile_questions"].each do |profile_question|
    pq = ps.profile_questions.create(question: profile_question["question"], answer_type: profile_question["answer_type"])
    if profile_question["profile_answers"]
      profile_question["profile_answers"].each do |profile_answer|
        pq.profile_answers.create(answer: profile_answer["answer"])
      end
    end
  end
end

# TODO: Setting up the default flirts
Flirt.destroy_all
messages = ['I like your profile!', 'Happy Birthday!', 'Your photo is hot!', "I'd like to meet you!", "Let's chat!", "I would love to get to know you!", "You are my Type!", "We make a good match!", "Let's go out!"]
messages.each do |message|
  Flirt.create(message: message)
end

support = User.new do |user|
  user.id = -1
  user.username = 'HyeDatingAida'
  user.gender = 'F'
  user.email = 'support@hyedating.com'
  user.password = 'support'
  user.password_confirmation = 'support'
  user.country = 'United States'
  user.city = 'Glendale'
  user.zip_code = '91202'
end
support.premium = true
support.save
support.geocode
support.user_activity = UserActivity.create!(activity_type: 'sign_up', gender: support.gender)
support.user_profile = UserProfile.create!
support.user_log = UserLog.create!(likes_viewed_at: Time.now, views_viewed_at: Time.now)

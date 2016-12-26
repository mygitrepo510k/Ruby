# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:username) { |n| "#{n}secretuser" }
  sequence(:email) { |u| "email-#{u}@example.com" }
  sequence(:admin_username) { |n| "admin#{n}" }
  sequence(:admin_email) { |u| "admin.email-#{u}@example.com" }
  factory :user do
    username { generate(:username) }
    email { generate(:email) }
    date_of_birth 23.years.ago
    country "United States"
    zip_code "90210"
    gender "M"
    city "Los Angeles"
    password "secret"
    password_confirmation "secret"
    firstname "user"
    lastname "valid"
    unsubscribe_token "E8Npt4x4XGTjxbPyh1NT"
    association :user_log
    association :user_activity
    association :user_profile
    latitude  48.8582
    longitude 2.2945
    activation_token nil
    active true
    activation_state "active"
    rating 1
    association :subscription
  end
  factory :admin do
    username { generate(:admin_username)}
    email {generate(:admin_email)}
    password "secret"
    password_confirmation "secret"
    activation_state "active"
    unsubscribe_token "E8Npt4x4XGTjxbPyh1NT"
  end
  factory :user_base do
    username { generate(:username) }
    email { generate(:email) }
    password "secret"
    password_confirmation "secret"
  end
end

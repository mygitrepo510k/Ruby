# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    title "Le title"
    about_me "I am a very nice individual"
    looking_for "Cats"
  end
end

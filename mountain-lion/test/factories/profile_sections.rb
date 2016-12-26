# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_section do
    name "Interests"
    association :profile_question
  end
end

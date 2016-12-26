# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_question do
    question "String profile question"
    profile_section
    answer_type "string"
    association :user_question
  end
  factory :string_profile_question, class: ProfileQuestion do
    question "String profile question"
    profile_section
    answer_type "string"
    association :user_question
  end
  factory :select_profile_question, class: ProfileQuestion do
    question "Select profile question"
    profile_section
    answer_type "select_list"
    association :user_question
  end
end

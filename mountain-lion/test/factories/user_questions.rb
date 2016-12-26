# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_question do
    user_id 1
    profile_question_id 1
    answer "MyString"
  end
end

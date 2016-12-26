# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_answer do
    profile_question ""
    answer "MyString"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    title "MyString"
    category "MyString"
    time_line false
    description "MyText"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    class_name "MyString"
    feedback_date "2013-06-25"
    type ""
    from "MyString"
    your_notes "MyText"
    important false
  end
end

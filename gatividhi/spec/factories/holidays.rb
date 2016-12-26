# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :holiday do
    class_name "MyString"
    title "MyString"
    start_date "2013-06-25"
    end_date "2013-06-25"
    type ""
    description "MyText"
    date_finalised false
  end
end

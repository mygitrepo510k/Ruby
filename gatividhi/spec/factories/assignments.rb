# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    class_name "MyString"
    title "MyString"
    category "MyString"
    subject "MyString"
    due_date "2013-06-25"
    due_time "2013-06-25 16:39:44"
    description "MyString"
    to_be_graded false
    scale "MyString"
  end
end

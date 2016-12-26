# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    email "MyString"
    birth_day "2013-06-22"
    country "MyString"
    state "MyString"
    city "MyString"
    address_line1 "MyString"
    address_line2 "MyString"
    pin_code "MyString"
    nationality "MyString"
  end
end

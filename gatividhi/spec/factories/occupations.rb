# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :occupation do
    occupation "MyString"
    company_name "MyString"
    industry "MyString"
    country "MyString"
    state "MyString"
    city "MyString"
    address_line1 "MyString"
    address_line2 "MyString"
    pin_code "MyString"
  end
end

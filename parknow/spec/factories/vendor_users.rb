# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vendor_user do
    user nil
    vendor nil
    name "MyString"
  end
end

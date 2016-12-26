# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    license_plate "MyString"
    customer nil
  end
end

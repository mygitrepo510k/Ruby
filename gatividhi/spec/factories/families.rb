# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :family do
    user nil
    family_name "MyString"
    family_id 1
  end
end

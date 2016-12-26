# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :family_member do
    family nil
    user nil
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    confirm_email "MyString"
    role_name "MyString"
    status "MyString"
    email_verification_hash "MyString"
  end
end

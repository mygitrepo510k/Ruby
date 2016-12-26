# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	role 'tester'
    invitation_id 1
    invitation_limit 1
    email "test@email.com"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    notification_type :welcome
    user 
    read false
  end
end

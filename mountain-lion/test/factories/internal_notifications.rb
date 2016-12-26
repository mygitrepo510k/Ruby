# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :internal_notification do
    message "MyText"
    displayed false
  end
end

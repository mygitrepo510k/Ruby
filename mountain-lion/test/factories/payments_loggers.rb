# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payments_logger do
    user nil
    message "MyText"
  end
end

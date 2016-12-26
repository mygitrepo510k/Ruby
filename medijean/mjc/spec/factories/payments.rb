# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    order_id 1
    charge_id "MyString"
    operation 1
    message "MyText"
    success 1
  end
end

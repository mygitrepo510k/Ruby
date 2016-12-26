# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_hold do
    customer 1
    service_contract 1
    debit 15
    credit 15
  end
end

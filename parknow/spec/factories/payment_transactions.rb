# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_transaction do
    sender_type "customer"
    sender_id 1
    receiver_type "vendor"
    receiver_id 1
    contract_id 1
    debit 15
    credit 15
    transaction_foreign_id "1"
  end
end

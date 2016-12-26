# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    belongs_to :user
    name "customer"
    balance 25
    available_balance 18
  end
end

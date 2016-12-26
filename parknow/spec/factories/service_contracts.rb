# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service_contract do
    parked_at "2014-03-19 00:32:48"
    deparked_at "2014-03-19 00:32:48"
    service_offer nil
    state "MyString"
  end
end

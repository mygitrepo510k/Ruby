# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service_offer do
    vendor nil
    vendor_terms nil
    service_request nil
    state "MyString"
  end
end

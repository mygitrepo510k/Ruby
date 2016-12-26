# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do
    country_code "MyString"
    state_code "MyString"
    name "MyString"
    geoname_id 1
  end
end

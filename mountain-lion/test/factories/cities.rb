# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    geoname_id 1
    name "MyString"
    latitude 1.5
    longitude 1.5
    country_code "MyString"
    state_code "MyString"
    state nil
  end
end

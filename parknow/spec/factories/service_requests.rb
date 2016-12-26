# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service_request do
    creation_date "MyString"
    customer nil
    vehicle nil
    latitude 1.5
    longitude 1.5
    expiry "2014-03-18 11:33:12"
    client_guid "MyText"
  end
end

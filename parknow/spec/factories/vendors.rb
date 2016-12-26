# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vendor do
    belongs_to ""
    name "vendor"
    latitude 1.5
    longitude 1.5
    bendor_description "vendor test"
  end
end

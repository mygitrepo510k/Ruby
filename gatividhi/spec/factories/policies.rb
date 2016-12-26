# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :policy do
    particular "MyString"
    date_paid "MyString"
    amount "MyString"
    description "MyString"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    user nil
    name "MyString"
    status "MyString"
    order_no ""
  end
end

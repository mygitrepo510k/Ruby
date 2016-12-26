# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "MyString"
    title "MyString"
    description "MyText"
    ispublic false
    moderator "MyString"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kc_page do
    title "Getting started"
    url "test_url"
    html "MyText"
    sort_order 1
    published true
    visible_to_doctors true
    visible_to_patients false
  end
end

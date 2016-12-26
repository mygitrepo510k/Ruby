# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_log do
    user nil
    likes_viewed_at "2013-04-13 22:10:30"
    views_viewed_at "2013-04-13 22:10:30"
  end
end

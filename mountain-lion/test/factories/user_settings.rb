# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_setting, :class => 'User::Setting' do
    message_email false
    flirt_email false
    match_email false
    views_email false
    user nil
  end
end

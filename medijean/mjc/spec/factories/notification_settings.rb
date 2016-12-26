# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_setting, :class => 'NotificationSettings' do
    user nil
    receive_message false
    has_news false
    has_tagged_me false
    receive_prescription false
  end
end

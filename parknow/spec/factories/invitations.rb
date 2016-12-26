# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_email "test@email.com"
    token "1c1c6e2884baadad0505a7c50519989090726490"
    sent_at "2014-03-21 01:04:16"
  end
end

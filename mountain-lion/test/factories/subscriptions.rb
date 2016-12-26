# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    member_id 1
    trans_id 1
    auth_code "MyString"
    auth_date "2013-07-02 20:49:08"
    auth_msg "MyString"
    recurring_id 1
    avs_code "MyString"
    cvv2_code "MyString"
    settle_amount "9.99"
    settle_currency "9.99"
    processor "MyString"
    user nil
  end
end

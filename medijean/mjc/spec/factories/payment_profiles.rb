# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_profile do
    user_id 1
    customer_id "cus_2TPCzTEPtFsz6a"
  end


  factory :payment_info do
    card_on_name "TestCard"
    card_number "4012 8888 8888 1881"
    cvc_number "1881"
    exp_month Date.today.month
    exp_year Date.today.year+3
  end


  factory :billing_info do
    street { Faker::Address.street_address }
    apart "No 25"
    city { Faker::Address.city }
    province { Faker::Address.state }    
    postal_code "V2P 6J4"    
  end  

end

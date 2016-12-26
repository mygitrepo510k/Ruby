# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vendor_term, :class => 'VendorTerms' do
    vendor nil
    enabled false
    hourly_rate 1.5
    max_hourly_hours 1.5
    flat_rate 1.5
    max_flat_hours 1.5
  end
end

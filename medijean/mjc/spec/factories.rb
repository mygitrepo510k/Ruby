FactoryGirl.define do
  trait :email do
    email { Faker::Internet.email }
  end

  trait :password do
    password { Faker::Lorem.characters(8) }
  end

  trait :name do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  trait :phone do
    phone { Faker::Base.numerify('###-###-####') }
  end

  trait :physician_id do
    physician_id { Faker::Base.numerify('##########') }
  end

  trait :invitation_token do
    invitation_token { Faker::Base.numerify('#################') }
  end

  trait :health_card_number do
    health_card_number { Faker::Base.bothify('####-####-####-###')}
  end

  factory :order do
    placed_at { Time.now }
    user

    association :shipping_address, :factory => :immutable_address

    status :placed
    sub_total { Faker::Base.numerify("##.##")}
    tax { Faker::Base.numerify("#.##") }
    total { Faker::Base.numerify("##.##")}
    taxname "HST"

    before(:create) do |order|
      order.line_items = build_list(:line_item, 1)
      prescription = create(:prescription, user: order.user)
      order.prescription = prescription
    end
  end

  factory :line_item do
    unit :grams
    quantity { Faker::Base.numerify("#") }
    medicine
    price { quantity * medicine.price }
  end

  factory :medicine do
    name { ["Strain 1", "Strain 2", "Strain 3", "Strain 4"].sample }
    price 1.00
    unit :grams
  end

  factory :address do
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    province { Faker::Address.state }
    postal_code "V2P 6J4"
    addressable_id nil
    addressable_type nil
    country

    factory :immutable_address do
      immutable true
    end
  end

  factory :country do
    code "CA"
    name "Canada"
  end

  factory :role do
    name "patient"

    factory :patient_role do
    end
    factory :doctor_role do
      name "doctor"
    end
  end

  factory :user do
    email
    password
    refill_reminder { Time.now }
    # roles {[FactoryGirl.create(:role)]}

    after(:create) { |user| user.confirm! }
    after(:create) { |user| FactoryGirl.create(:profile, user: user)}

    factory :patient_user do
      roles {[FactoryGirl.create(:role)]}
    end

    factory :doctor_user do
      roles {[FactoryGirl.create(:doctor_role)]}
      after(:create) { |user| user.linked_doctor = FactoryGirl.create(:doctor) }
    end
  end

  factory :admin_user do
    email
    password
  end

  factory :profile do
    name
    phone
    health_card_number
    user
  end

  factory :clinic do
    name { Faker::Company.name }
    phone
    website { Faker::Internet.domain_name }
    after(:build) { |clinic| clinic.build_address(FactoryGirl.attributes_for(:address)) }
  end

  factory :doctor, aliases: [:linked_doctor] do
    name
    gender :male
    physician_id
    clinic
    user_id nil

    factory :active_doctor do
      status :active
    end
  end

  factory :doctor_patient do
    doctor
    user
    status :tagged
    email
    health_card_number { user.try(:profile).try(:health_card_number) }
    invitation_token

    factory :doctor_patient_invited_state do
      health_card_number
      association :prescription, factory: :prescription_without_user, strategy: :build
      user nil
      status :invited
    end
  end

  factory :dosage do
    quantity { Faker::Base.numerify("#")}
    unit :grams
    frequency :daily
  end

  factory :prescription do
    medicine
    status :prescribed
    symptom "Stress"
    user
    issue_date { Time.now }
    expiration { Time.now + 1.year}
    doctor_name 'Dr. Test'
    doctor
    administration_method :vaporization
    dosage
    doctor_id { doctor_patient.try(:doctor).try(:id) }
    initialize_with { Prescription.skip_callback(:create, :after, :send_invitation); new }

    factory :prescription_without_user do
      user nil
    end
  end

  
end
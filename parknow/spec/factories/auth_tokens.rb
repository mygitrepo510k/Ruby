# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auth_token do
    belongs_to :user
    token "37490db95a8a91dabe973699ed7b7897106e755c-kmaKLYC-FZklG0t6GYt3Pg"
    device_id "4x4812354sd45fw98e4546a1w510a123df132gf12gh1fg4hr45w63szx0z"
    device_type "ios"
  end
end

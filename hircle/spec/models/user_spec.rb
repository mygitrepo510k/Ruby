require 'spec_helper'

describe User do
  it "Creating User" do 
    User.create(
    :email=>'admin@hircle.com',
    :password=>"12345678",
    :password_confirmation=>"12345678",
    :role_id=>1,
    :first_name =>"admin"
    )
      
    user  = User.all.first
    expect(user.email).to eq("admin@hircle.com")
  end
end

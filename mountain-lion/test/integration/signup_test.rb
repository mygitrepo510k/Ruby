require 'test_helper'

describe "Signup Integration Test" do
  it "must have the required content" do
    visit signup_path
    page.must_have_content('I am a Select GenderMaleFemale')
    page.must_have_content('Email')
    page.must_have_content('Date of Birth')
    page.must_have_content('Password')
    page.must_have_content('Confirm Password')
    page.must_have_button('Join Now')
  end
  it "must signup a user with valid parameters" do
    require_selenium
    User.delete_all
    user = FactoryGirl.build(:user)
    visit signup_path
    select('Male', from: 'registration_one_gender')
    fill_in("Email", with: user.email)
    page.execute_script %Q{ $('#registration_one_date_of_birth').trigger("focus") } # activate datetime picker
    page.execute_script %Q{ $('a.ui-datepicker-previous').trigger("click") } # move one month forward
    page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15
    find("#registration_one_password").set("secret")
    find("#registration_one_password_confirmation").set("secret")
    click_button("Join Now")
    fill_in("Username", with: user.username)
    fill_in("First Name", with: user.firstname)
    fill_in("Last Name", with: user.lastname)
    select("United States", from: 'registration_two_country_code')
    fill_in("City", with: user.city)
    fill_in("Zip Code", with: user.zip_code)
    click_button("Continue")
    sleep 5
    current_path.must_equal(confirmation_path)
    User.count.must_be :>, 0
  end
end

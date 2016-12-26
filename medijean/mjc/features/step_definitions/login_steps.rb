Then(/^I should be logged in$/) do
  page.should have_css('#user-navbar')
end

Given(/^I have entered a bad password$/) do
  fill_in "user_password", :with => "blah"
end

Given(/^a "(.*?)" with email "(.*?)" and password "(.*?)"$/) do |role, email, password|
  @email = email
  @password = password
  @user = FactoryGirl.create("#{role}_user", email: email, password: password)
end

Given(/^I have completed my profile$/) do
  @user.update_attribute(:profile_updated, true)
end

Given(/^I have not completed my profile$/) do
  @user.linked_doctor.destroy if @user.linked_doctor
  @user.update_attribute(:profile_updated, false)
end


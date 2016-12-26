Given(/^I am logged in$/) do
  visit new_user_session_path
  fill_in 'E-mail Address', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Sign In'
end

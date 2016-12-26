Given /^I am on (.+)$/ do |page_name|
  visit path_to page_name
end

When /I (?:go to|visit) (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button button
end

When /^I click "([^\"]*)"$/ do |button|
  click_button button
end

When /^I click within "([^"]*)"$/ do |selector|
  find(selector).click
end

When /^I follow "([^\"]*)"$/ do |link|
  click_link link
end

When /^I click at "([^\"]*)" element$/ do |element|
  click element
end

Given /^I fill "(.*?)" in "(.*?)"$/ do |value, field|
  fill_in field, with: value
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select value, from: field
end

When /^I set value "([^\"]*)" in field "([^\"]*)"$/ do |value, selector|
  find(selector).set(value)
end

When /^I check "([^\"]*)"$/ do |field|
  check field
end

When /^I uncheck "([^\"]*)"$/ do |field|
  uncheck field
end

When /^I choose "([^\"]*)"$/ do |field|
  choose field
end

When /^I attach the file at "([^\"]*)" to "([^\"]*)"$/ do |path, field|
  attach_file field, path
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I should be on (.+)$/ do |page_name|
  url = URI.parse(current_url)
  url = url.query ? url.path+'?'+url.query: url.path
  url.should == path_to(page_name)
end

Then /^screenshot$/ do
  Capybara::Screenshot.screenshot_and_save_page
end

Then /^Page should have selector "([^\"]*)"$/ do |selector|
  page.should have_selector(selector)
end

Then /^I should see "([^"]*)" in "([^"]*)"/ do |content, selector|
  find(selector).value.should == content
end

Then /^Selector "([^"]*)" should be checked/ do |selector|
  find(selector).should be_checked
end
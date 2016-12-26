Given(/^Doctor profile exists with Physician No equal "(.*?)"$/) do |physician_id|
  @doctor_profile = FactoryGirl.create(:doctor, physician_id: physician_id)
end

Then(/^I should see filled doctor profile fields$/) do
  page.should have_content @doctor_profile.first_name
  page.should have_content @doctor_profile.last_name
  @doctor_profile.phone.split('-') do |phone_part|
    page.should have_content phone_part
  end
  page.should have_content @doctor_profile.gender
  page.should have_content @doctor_profile.clinic.name
  @doctor_profile.clinic.phone.split('-') do |phone_part|
    page.should have_content phone_part
  end
  page.should have_content @doctor_profile.clinic.website
  page.should have_content @doctor_profile.clinic.street
  page.should have_content @doctor_profile.clinic.city
  page.should have_content @doctor_profile.clinic.province
end
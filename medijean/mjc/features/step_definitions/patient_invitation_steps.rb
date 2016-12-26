Given(/^I have been invited by doctor$/) do
  @doctor_patient = FactoryGirl.create(:doctor_patient_invited_state, email: 'patient@medijean.com')
end

Given(/^I follow invitation link$/) do
  visit invitation_confirmation_url(token: @doctor_patient.invitation_token)
end
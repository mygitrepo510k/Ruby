Given(/^create prescription$/) do
  @prescription = FactoryGirl.create(:prescription, user: @user, issue_date: Time.now)
  @doctor = FactoryGirl.create(:doctor)
  @prescription.doctor = @doctor
end
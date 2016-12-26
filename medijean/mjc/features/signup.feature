Feature: sign up
  In order to have access to the system
  As a guest
  I want to create an account for me

  Scenario: patient sign up
    Given I am on "the homepage"
    And I fill "patient@medijean.com" in "user_email"
    And I fill "password" in "Password"
    When I click "Sign up as a Patient"
    Then "patient@medijean.com" should receive an email
    When I open the email
    And I follow "Confirm my account" in the email
    Then I should be logged in
    And I should see "Your account was successfully confirmed. You are now signed in."
    And I should be on "the patient profile page"


  Scenario: doctor sign up
    Given I am on "the doctor registration page"
    And I fill "doctor@medijean.com" in "user_email"
    And I fill "password" in "Password"
    When I click "Sign up as a Doctor"
    Then "doctor@medijean.com" should receive an email
    When I open the email
    And I follow "Confirm my account" in the email
    And I should see "Your account was successfully confirmed. You are now signed in."
    And I should be on "new doctor page"

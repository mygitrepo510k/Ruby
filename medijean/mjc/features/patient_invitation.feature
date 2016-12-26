Feature: Patient Invitation
  In order to use the system
  As a user of the system
  I want to be able to follow my doctor invitation

  Scenario: patient signups using confirmation link
    Given I have been invited by doctor
    Given I follow invitation link
    And I should be on "invitation confirmation page"
    And I fill "1111111111" in "profile_health_card_number"
    And I fill "password" in "user_password"
    And I fill "John" in "profile_first_name"
    And I fill "Smith" in "profile_last_name"
    And I fill "111" in "profile_phone_p1"
    And I fill "222" in "profile_phone_p2"
    And I fill "3333" in "profile_phone_p3"
    And I click "Complete Registration"
    Then I should be on "the prescription review page"

  Scenario: patient signups being already invited
    Given I have been invited by doctor
    Given I am on "the homepage"
    And I fill "patient@medijean.com" in "user_email"
    And I fill "password" in "Password"
    When I click "Sign up as a Patient"
    And I should be on "invitation confirmation page"
    And I fill "1111111111" in "profile_health_card_number"
    And I fill "John" in "profile_first_name"
    And I fill "Smith" in "profile_last_name"
    And I fill "111" in "profile_phone_p1"
    And I fill "222" in "profile_phone_p2"
    And I fill "3333" in "profile_phone_p3"
    And I click "Complete Registration"
    Then I should be on "the prescriptions path"
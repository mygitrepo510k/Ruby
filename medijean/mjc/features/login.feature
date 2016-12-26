Feature: log in
  In order to use the system
  As a user of the system
  I want to log in to the system

  Scenario: profile completed patient log in
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am on "the log in page"
    And I fill "patient@medijean.com" in "E-mail Address"
    And I fill "password" in "Password"
    When I click "Sign In"
    Then I should be logged in
    And I should be on "the prescriptions path"

  Scenario: profile uncompleted patient log in
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have not completed my profile
    And I am on "the log in page"
    And I fill "patient@medijean.com" in "E-mail Address"
    And I fill "password" in "Password"
    When I click "Sign In"
    Then I should be logged in
    And I should be on "the patient profile page"

  Scenario: profile completed doctor log in
    Given a "doctor" with email "doctor@medijean.com" and password "password"
    And I have completed my profile
    And I am on "the log in page"
    And I fill "doctor@medijean.com" in "E-mail Address"
    And I fill "password" in "Password"
    When I click "Sign In"
    Then I should be logged in
    And I should be on "the doctor dashboard"

  Scenario: profile uncompleted doctor log in
    Given a "doctor" with email "doctor@medijean.com" and password "password"
    And I have not completed my profile
    And I am on "the log in page"
    And I fill "doctor@medijean.com" in "E-mail Address"
    And I fill "password" in "Password"
    When I click "Sign In"
    Then I should be logged in
    And I should be on "new doctor page"

  Scenario: invalid credentials
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have not completed my profile
    And I am on "the log in page"
    And I fill "patient@medijean.com" in "E-mail Address"
    And I fill "password123" in "Password"
    When I click "Sign In"
    Then I should be on "the log in page"
    And I should see "Invalid email or password"
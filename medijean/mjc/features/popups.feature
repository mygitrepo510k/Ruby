Feature: Popups
  I want to check all popups

  Scenario: Patient popups
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    When I click within "#notification-count"
    Then I should see "See All Notifications"
    When I click within "b.caret"
    Then I should see "Sign Out"

  Scenario: Doctor popups
    Given a "doctor" with email "doctor@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    When I click within "#notification-count"
    Then I should see "See All Notifications"
    When I click within "b.caret"
    Then I should see "Sign Out"
    When I click within "a:contains('Invite Patients')"
    Then I should see "Invite New Patient"
    When I click within "a:contains('Add your patients')"
    Then I should see "Invite New Patient"

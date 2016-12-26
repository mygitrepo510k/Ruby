Feature: Settings
  I want to check settings

  Scenario: Settings patient profile
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    And I click within "b.caret"
    And I click within "a[href='/settings/profile']"
    Then I should be on "the settings profile"
    And I fill "FirstName" in "profile_first_name"
    And I fill "LastName" in "profile_last_name"
    And I select "2010" from "profile_date_of_birth_1i"
    And I select "September" from "profile_date_of_birth_2i"
    And I select "7" from "profile_date_of_birth_3i"
    And I select "Male" from "profile_gender"
    And I fill "123" in "profile_phone_p1"
    And I fill "123" in "profile_phone_p2"
    And I fill "123" in "profile_phone_p3"
    And I click within "input[name='commit']"
    Then I should be on "the settings profile"
    And I should see "FirstName" in "#profile_first_name"
    And I should see "LastName" in "#profile_last_name"
    And I should see "2010" in "#profile_date_of_birth_1i"
    And I should see "9" in "#profile_date_of_birth_2i"
    And I should see "7" in "#profile_date_of_birth_3i"
    And I should see "male" in "#profile_gender"
    And I should see "123" in "#profile_phone_p1"
    And I should see "123" in "#profile_phone_p2"
    And I should see "123" in "#profile_phone_p3"

  Scenario: Settings patient notification
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    And I am on "the settings notifications"
    And I check "I receive a message from a doctor on Medijean"
    And I check "MediJean has news about MedicaL Marijuana"
    And I check "A doctor on MediJean has tagged me"
    And I check "I receive a prescription"
    When I click "Save Changes"
    Then I should be on "the settings notifications"
    And Selector "#notification_settings_receive_message" should be checked
    And Selector "#notification_settings_has_news" should be checked
    And Selector "#notification_settings_has_tagged_me" should be checked
    And Selector "#notification_settings_receive_prescription" should be checked



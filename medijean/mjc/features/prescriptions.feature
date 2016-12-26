Feature: Prescriptions
  In order to take service from the system
  As a patient
  I want to manage my prescriptions

  Scenario: Prescription Upload
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    Then I should be on "the prescriptions path"
    And I visit "the prescriptions upload page"
    And I attach the file at "fixtures/prescription.png" to "prescription_prescription_image"
    And I fill "Dr. XYZ" in "prescription_doctor_name"
    And I select "AIDS" from "prescription_symptom"
    And I select "Chronic user" from "prescription_current_usage_habits"
    And I select "1g/day" from "prescription_dosage"
    And I select "Combustion" from "prescription_administration_method"
    And I select "1" from "prescription_issue_date_3i"
    And I select "May" from "prescription_issue_date_2i"
    And I select "2008" from "prescription_issue_date_1i"
    And I select "June" from "prescription_expiration_2i"
    And I select "1" from "prescription_expiration_3i"
    And I select "2014" from "prescription_expiration_1i"
    And I fill "XYZ" in "prescription_description"
    And I select "Strain 3" from "prescription_medicine_id"
    And I click "Next >"
    Then I should be on "the prescription review page"
    When I follow "Accept Prescription"
    Then I should be on "the new order page"
    When I visit "the prescriptions path"
    Then I should see "Dr. XYZ"
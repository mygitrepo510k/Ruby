Feature: sign up
  I want to complete profile
  I want invite patient
  Scenario: complete doctor profile
    Given a "doctor" with email "doctor@medijean.com" and password "password"
    And I have not completed my profile
    And I am logged in
    Then I should be on "the doctor profile page"
    When I fill "111" in "doctor_physician_id"
    And I fill "FirstName" in "doctor_first_name"
    And I fill "LastName" in "doctor_last_name"
    And I fill "123" in "doctor_phone_p1"
    And I fill "123" in "doctor_phone_p2"
    And I fill "123" in "doctor_phone_p3"
    And I fill "123" in "clinic_phone_p1"
    And I fill "123" in "clinic_phone_p2"
    And I fill "123" in "clinic_phone_p3"
    And I fill "clinic address" in "doctor_clinic_address_attributes_street"
    And I fill "clinic city" in "doctor_clinic_address_attributes_city"
    And I fill "clinic province" in "doctor_clinic_address_attributes_province"
    And I click within "input[name=commit]"
    Then I should be on "the doctors dashboard page"
    And I should see "Thank you Mr. LastName for submitting your professional credentials. Our MediJean staff will call you shortly to complete the verification process."

  Scenario: invite patient
    Given a "doctor" with email "doctor@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    Then I should be on "the doctors dashboard page"
    When I click within "a.btn.gb-btn"
    Then I should see "Invite New Patient"
    And I fill "patient@medijean.com" in "doctor_patient_email"
    And I fill "123-123-123-321" in "doctor_patient_health_card_number"
    And I click within "input[name=commit]"
    And I should see "New patient added!"

  Scenario: complete patient profile
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have not completed my profile
    And I am logged in
    Then I should be on "the patient profile page"
    When I fill "FirstName" in "profile_first_name"
    And I fill "LastName" in "profile_last_name"
    And I fill "123-123-123-321" in "profile_health_card_number"
    And I set value "123" in field "#profile_phone_p1"
    And I set value "123" in field "#profile_phone_p2"
    And I set value "1234" in field "#profile_phone_p3"
    And I click within "input[name=commit]"
    Then I should be on "prescription upload page"

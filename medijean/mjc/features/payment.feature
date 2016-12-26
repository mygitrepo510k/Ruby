Feature: Prescriptions
  I want to payment prescriptions

  Scenario: Payment
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    And create prescription
    Then I am on "the prescriptions path"
    And I click within "a[href='/orders/new?prescription_id=1']"
    Then I should be on "the new order page"
    And I fill "MasterCard" in "name"
    And I fill "5555 5555 5555 4444" in "card_number"
    And I fill "4442" in "card_code"
    And I fill "test 123" in "address_street"
    And I fill "101" in "address_unit"
    And I fill "Toronto" in "address_city"
    And I fill "L3T 4A9" in "address_postal_code"
    And I select "2015" from "card_year"
    And I click "Next"
    Then I should be on "the orders completed page"
    And I should see "Thank You"




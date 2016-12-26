Feature: check links
  I want to check all links

  Scenario: Check doctors links
    Given a "doctor" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    Then I should be on "the doctor dashboard"
    And I click within "a[href='/notifications']"
    Then I should be on "the notifications page"
    And I click within "a[href='/knowledge_centre']"
    Then I should be on "the knowledge center page"
    And I click within "a[href='/doctors/dashboard']"
    Then I should be on "the doctor dashboard"

  Scenario: Check patient links
    Given a "patient" with email "patient@medijean.com" and password "password"
    And I have completed my profile
    And I am logged in
    Then I should be on "the prescriptions path"
    And I click within "a[href='/orders']"
    Then I should be on "the orders page"
    And I click within "a[href='/notifications']"
    Then I should be on "the notifications page"
    And I click within "a[href='/knowledge_centre']"
    Then I should be on "the knowledge center page"
    And I click within "a[href='/kc/faqs']"
    Then Page should have selector "li.active>a[href='/kc/faqs']"
    And I click within "a[href='/kc/medijean_strains']"
    Then Page should have selector "li.active>a[href='/kc/medijean_strains']"
    And I click within "a[href='/kc/benefits_side_effects']"
    Then Page should have selector "li.active>a[href='/kc/benefits_side_effects']"
    And I click within "a[href='/kc/getting_started']"
    Then Page should have selector "li.active>a[href='/kc/getting_started']"


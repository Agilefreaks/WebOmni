Feature: Authentication
  In order to download the app
  As an user
  I want to sign in or sign up

Scenario: Sign-in
  Given I am on the home page
  And user with email "calin@people.com" does exists
  When I follow "Sign in"
  Then I should see a "Get Omnipaste" and "Get Authorization Code"

Scenario: Sign-up
  Given I am on the home page
  And user with email "calin@people.com" does not exists
  When I follow "Sign in"
  Then I should see a "Get Omnipaste" and "Get Authorization Code"
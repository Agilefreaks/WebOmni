Feature: Authentication
  In order to download the app
  As an user
  I want to sign in or sign up

Scenario: Sign-up
  Given I am on the home page
  And user with email calin@people.com exists
  When I follow "Sign in"
  Then I should see a "Get Omnipaste" and "Get Authorization Code"
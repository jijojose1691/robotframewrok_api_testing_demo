*** Settings ***
Documentation    Tests for Cart API
Resource        ../../Keywords/Cart/Cart_Keywords.robot

Suite Setup       Suite Setup With Authenitcation
Suite Teardown    Suite Teardown With Authenitcation

*** Test Cases ***
[Cart API] Verify cart with zero items
    [Documentation]    Test the API endpoint that returns an empty cart
    [Tags]    cart   P0
    When I clear the shopping cart with valid auth token ${AUTH_TOKEN} with a status ${STATUS_OK}
    Then I verify the shopping cart is empty

[Cart API] Verify clear cart operation
    [Documentation]    Test the API endpoint that clears the shopping cart
    [Tags]    cart   P0
    Given I add an available item to cart
    When I clear the shopping cart with valid auth token ${AUTH_TOKEN} with a status ${STATUS_OK}
    Then I verify the shopping cart is empty


[Cart API] Verify clear cart with wrong authentication token
    [Documentation]    Test the API endpoint that clears the shopping cart with an invalid auth token
    [Tags]    cart    cart-error-handling     P0
    Given I add an available item to cart
    And I try to generate invalid token
    When I clear the shopping cart with valid auth token ${INVALID_AUTH_TOKEN} with a status ${UNAUTHORZED_STATUS}
    Then I verify the shopping cart is not empty


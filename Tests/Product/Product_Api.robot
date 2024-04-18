*** Settings ***
Documentation    Tests for Product API
Resource        ../../Keywords/Product/Product_Keywords.robot

Suite Setup       Test Suite Setup
Suite Teardown    Delete All Sessions

*** Test Cases ***
[Product API] Fetch product deatils list
    [Documentation]    Test the API endpoint that returns a list of products
    [Tags]    product    P0
    When I recieve the default product list
    Then I verify that product list is not empty

[Product API] Fetch product deatils list with limit
    [Documentation]    Test the API endpoint that returns a list of products for
    ...    the given limit
    [Tags]    product    P0
    When I recieve the default product list with a limit    ${PRODUCT_LIST_LIMIT}
    Then I verify that product list is not empty

[Product API] Read single product deatil successfully
    [Documentation]    Test the API endpoint that returns a single product detail for
    ...    the given product ID
    [Tags]    product    P0
    When I recieve the product details of ${BREAD_PRODUCT_ID} with status ${STATUS_SUCCESS}
    Then I verify the product details are not empty
    And I verify that the product details response is accurate    ${PRODUCT_API_RESPONSE}

[Product API] Try to fetch Get product details for a non existent id
    [Documentation]    Test the API endpoint that returns a single product for
    ...    the given ID which is not exist
    [Tags]    product    product-error-handling    P1
    When I recieve the product details of ${NON_EXIST_PRODUCT_ID} with status ${NOT_FOUND_STATUS}
    Then I verify that error message ${ERROR_NON_EXISTING_PRODUCT} is present in response ${PRODUCT_API_RESPONSE}


[Product API] Get product details for an invalid prodcut id
    [Documentation]    Test the API endpoint that returns a single product for
    ...    the given invalid ID
    [Tags]    product    product-error-handling    P0
    When I recieve the product details of ${INVALID_PRODUCT_ID} with status ${VALIDATION_ERROR_STATUS}
    Then I verify that error message ${ERROR_UNPROCESSABLE_ENTITY} is present in response ${PRODUCT_API_RESPONSE}
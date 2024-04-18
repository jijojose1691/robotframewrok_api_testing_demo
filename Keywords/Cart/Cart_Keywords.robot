*** Settings ***
Resource        ../Common/Common.robot

*** Keywords ***
Suite Setup With Authenitcation
    [Documentation]    Suit setup to make sure that the cart is empty for the recieved
    ...    authentication token.
    Set Server Base URL
    ${token}    Generate Valid Authentication Token
    Set Suite Variable  ${AUTH_TOKEN}  ${token}
    Clear shopping cart   ${AUTH_TOKEN}

Suite Teardown With Authenitcation
    [Documentation]    The teardown to make sure that the cart is empty for the given authentication token
    ...    and delete the token
    Clear shopping cart    ${AUTH_TOKEN}
    ${response}=    DELETE    ${BASE_URL}${AUTH_ENDPOINT}    headers=${AUTH_TOKEN}
    Should Be Equal As Strings  ${response.status_code}  204
    Delete All Sessions

Generate Valid Authentication Token
    [Documentation]    Keyword to  generate an auth token and set it as test variable
    ${response}=    GET    ${BASE_URL}${AUTH_ENDPOINT}
    Should Be Equal As Strings  ${response.status_code}  200
    ${response_data}    Set Variable    ${response.json()}
    ${token}=  Create Dictionary    x-auth=${response_data}[token]
    [Return]    ${token}

Validate Empty Cart Data
    [Documentation]    Check whether the given cart data is matching with empty cart informarion
    [Arguments]    ${cart_data}
    Should Be Empty    ${cart_data}[items]
    Should Be Equal As Numbers   ${cart_data}[total]   ${EMPTY_CART_SIZE}

Validate Non Empty Cart Data
    [Documentation]    Check whether the given cart data is matching with non empty cart informarion
    [Arguments]    ${cart_data}
    Should Not Be Empty    ${cart_data}[items]
    Should Not Be Equal As Numbers   ${cart_data}[total]   ${EMPTY_CART_SIZE}

I verify the shopping cart is empty
    [Documentation]    Verify the API to  the empty cart
    ${response}=    GET    ${BASE_URL}${CART_ENDPOINT}    headers=${AUTH_TOKEN}
    Should Be Equal As Strings    ${response.status_code}    200
    ${cart_data}    Set Variable    ${response.json()}
    Validate Empty Cart Data    ${cart_data}


I verify the shopping cart is not empty
    [Documentation]    Verify the API to non empty cart
    ${response}=    GET    ${BASE_URL}${CART_ENDPOINT}    headers=${AUTH_TOKEN}
    Should Be Equal As Strings    ${response.status_code}    200
    ${cart_data}    Set Variable    ${response.json()}
    Validate Non Empty Cart Data    ${cart_data}

Clear shopping cart
    [Documentation]    Perform the request to clear shopping cart
    [Arguments]    ${auth_token}     ${status_code}=${STATUS_OK}
    ${response}=    POST  ${BASE_URL}${CLEAR_CART_ENDPOINT}    headers=${auth_token}    expected_status=${status_code}
    Should Be Equal As Strings  ${response.status_code}     ${status_code}

I add an available item to cart
    [Documentation]    Add an avaialbe item to the customer cart
    ${available_product}=    Choose A Random Available Product
    ${products_to_be_add}=   Create Dictionary    product_id=${available_product}[id]    quantity=1
    ${cart_list} =  Create List
    Append To List    ${cart_list}    ${products_to_be_add}
    ${response}=    PATCH  ${BASE_URL}${CART_ENDPOINT}    headers=${AUTH_TOKEN}     json=${cart_list}
    Should Be Equal As Strings  ${response.status_code}  200

Choose A Random Available Product
    [Documentation]    Find a random available product via /products API and return as Dictionary.
    ...    It returns None if products are not available
    ${response}=    GET    ${BASE_URL}${PRODUCTS_ENDPOINT}
    Should Be Equal As Strings    ${response.status_code}    200
    ${product_list}    Set Variable    ${response.json()}
    FOR  ${product}  IN  @{product_list}[products]
        ${is_available} =  Get From Dictionary  ${product}    is_available
        Run Keyword If  ${is_available} == True
        ...  Return From Keyword  ${product}
    END
    [Return]  None

I clear the shopping cart with valid auth token ${auth_token} with a status ${status}
    [Documentation]    Perform the request to clear shopping cart with given auth token and expected status code
    Clear shopping cart    ${auth_token}    ${status}

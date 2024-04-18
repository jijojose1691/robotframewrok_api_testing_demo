*** Settings ***
Library   Collections
Library   RequestsLibrary
Library	  JSONLibrary
Library   Common.CommonUtils

*** Variables ***
${PRODUCTS_ENDPOINT}    /products/
${CART_ENDPOINT}    /cart/
${AUTH_ENDPOINT}    /auth/
${CLEAR_CART_ENDPOINT}     /cart/clear
${BREAD_PRODUCT_ID}    104
${NON_EXIST_PRODUCT_ID}    0
${EMPTY_CART_SIZE}  0
${PRODUCT_LIST_LIMIT}    5
${INVALID_PRODUCT_ID}    xxx
${BREAD_PRODUCT_ID}    104
${NOT_FOUND_STATUS}    404
${UNAUTHORZED_STATUS}    401
${VALIDATION_ERROR_STATUS}    422
${STATUS_SUCCESS}    200
${STATUS_OK}    204
${BREAD_PRODUCT_NAME}    Bread
${ERROR_NON_EXISTING_PRODUCT}
...    Product not found
${ERROR_UNPROCESSABLE_ENTITY}
...    value is not a valid integer



*** Keywords ***
Verify error handling
    [Documentation]    Verify whether the given response contain given error message
    [Arguments]    ${response}    ${message}
    ${response_string} =    Evaluate    json.dumps($response)
    Should Contain   ${response_string}   ${message}

I try to generate invalid token
    [Documentation]  Generate a random string as auth token and creat an invalid header
    ${random_token}    Generate Auth Token
    Log To Console     ${random_token}
    ${invalid_header}=  Create Dictionary    x-auth=${random_token}
    Set Suite Variable  ${INVALID_AUTH_TOKEN}  ${invalid_header}

Set Server Base URL
    [Documentation]  The method is to set the base URL of server where application is hosted
    ${HOST_IP}    Get Variable Value  ${HOST_IP}    localhost
    ${HOST_PORT}    Get Variable Value  ${HOST_PORT}    80
    Set Global Variable  ${BASE_URL}  http://${HOST_IP}:${HOST_PORT}
    Log  BASE URL: ${BASE_URL}

Test Suite Setup
    [Documentation]   Default test suit setup
    Set Server Base URL

I verify that error message ${error_message} is present in response ${response}
   [Documentation]  The keyword to verify whether the given error messsage is present
   ...    in the given response
   Verify error handling    ${response}    ${error_message}
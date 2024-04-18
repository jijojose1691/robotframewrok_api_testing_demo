*** Settings ***
Resource        ../Common/Common.robot

*** Keywords ***

I recieve the default product list
    [Documentation]    Recieve default products list via /products API
    ${response}=    GET    ${BASE_URL}${PRODUCTS_ENDPOINT}
    Should Be Equal As Strings    ${response.status_code}    200
    Set Test Variable    ${PRODUCT_API_RESPONSE}    ${response.json()}

I verify that product list is not empty
    Verify Product List Size    ${PRODUCT_API_RESPONSE}
    Validate Products List Details    ${PRODUCT_API_RESPONSE}

I verify the product details are not empty
    Should Not Be Empty   ${PRODUCT_API_RESPONSE}

I recieve the default product list with a limit
    [Documentation]    Recieve default products list via /products API with limit parameter
    [Arguments]    ${product_list_limit}=100
    ${response}=    GET    ${BASE_URL}${PRODUCTS_ENDPOINT}   params=limit=${product_list_limit}
    Should Be Equal As Strings    ${response.status_code}    200
    Set Test Variable    ${PRODUCT_API_RESPONSE}    ${response.json()}
    ${products_count} =  Get Length  ${PRODUCT_API_RESPONSE}[products]
    Should Be Equal As Numbers    ${products_count}    ${product_list_limit}

I recieve the product details of ${product_id} with status ${status}
    [Documentation]    Recieve products details via /products/`targeted_product_id` API for the given product ID
    ${response}=    GET    ${BASE_URL}${PRODUCTS_ENDPOINT}${product_id}    expected_status=${status}
    Should Be Equal As Strings    ${response.status_code}    ${status}
    Set Test Variable    ${PRODUCT_API_RESPONSE}    ${response.json()}

Validate Products List Details
    [Documentation]    Check whether the given product list response contains the required elements with
    ...    required data type
    [Arguments]    ${product_list}
    FOR    ${product}    IN    @{product_list}[products]
       Verify Response Data    ${product}    price   float
       Verify Response Data    ${product}    category    str
       Verify Response Data    ${product}    is_available    bool
       Verify Response Data    ${product}    id   int
       Verify Response Data    ${product}    name    str
    END

Verify Product List Size
    [Documentation]    Confirm that the value of the "count" key matches the number of items in the "products" list.
    [Arguments]    ${product_list}
    ${products_count} =  Get Length  ${product_list}[products]
    Should Be Equal As Numbers    ${products_count}    ${product_list}[count]

 I verify that the product details response is accurate
    [Documentation]    Validate the data types of items in the "products" key in response
    [Arguments]    ${product_data}
    Should Be Equal As Strings    ${product_data}[id]    ${BREAD_PRODUCT_ID}
    Should Be Equal As Strings    ${product_data}[name]    ${BREAD_PRODUCT_NAME}
    Verify Response Data    ${product_data}    price   float
    Verify Response Data    ${product_data}    category    str
    Verify Response Data    ${product_data}    is_available    bool
    Verify Response Data    ${product_data}    id   int
    Verify Response Data    ${product_data}    name    str

Verify Response Data
    [Documentation]    Validate the data types of the "product" and check if the provided data object
    ...    contains the specified key. Ensure that the data type of the value matches the specified requirement.
    [Arguments]    ${data}    ${key}    ${type}
    Should Contain    ${data}    ${key}
    Validate Response Value Type     ${data}    ${key}    ${type}

Validate Response Value Type
    [Documentation]    Confirm if the data type of the provided key matches the specified data type.
    [Arguments]    ${response_string}    ${key}    ${expected_type}
    ${value}=    Get From Dictionary   ${response_string}    ${key}
    ${current_type} =  Evaluate  type($value).__name__
    Should Be Equal As Strings    ${current_type}    ${expected_type}
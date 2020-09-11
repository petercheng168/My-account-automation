*** Settings ***
Documentation    Test suite of login Sales_Portal 
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Open Browser    ${SALES_PORTAL_URL}    ${SALES_PORTAL_WINDOW_HEIGHT}    ${SALES_PORTAL_WINDOW_WEIGHT}
Suite Teardown    Close All Browsers
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Check login function with enter key
    [Tags]    CID:6653
    Input Login Page Content    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Press Enter Key To Login
    Click Get 2FA Email Button
    Check Remember Checkbox Unavailable
    Click 2FA Confirm Button To Login
    ${department_name} =    Get Account Information
    Verify Company Code    GSS
    Verify Logout Area Account Information    ${department_name} / ${SALES_ACCOUNT}
    Verify Menu Icon Exist
    [Teardown]    Click Logout Button

Check privacy policy
    [Tags]    CID:6656
    Click Privacy Policy
    Switch Window Tab    1
    Verify Page URL    https://policies.google.com/privacy
    [Teardown]    Test Teardown For Privacy Policy

Check terms of service
    [Tags]    CID:6657
    Click Terms Of Service
    Verify Page URL    https://policies.google.com/terms
    [Teardown]    Go To    ${SALES_PORTAL_URL}/home?p=login

Login with correct information
    [Tags]    CID:6654
    Input Login Page Content    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Click Login Button
    Click Get 2FA Email Button
    Check Remember Checkbox Unavailable
    Click 2FA Confirm Button To Login
    Verify Company Code    GSS
    Verify Logout Area Account Information    土城裕民店 / ${SALES_ACCOUNT}
    Verify Menu Icon Exist
    [Teardown]    Click Logout Button

Login with wrong information
    [Tags]    CID:6661
    Login With Information    ${SALES_ACCOUNT}    234
    Verify Popup Window Message    Error, L0001 Login fail. (Validation Error)
    Verify Page URL    ${SALES_PORTAL_URL}/home?p=login
    [Teardown]    Test Teardown For Login With Wrong Information

Login without account information
    [Tags]    CID:6658
    Login With Information    ${EMPTY}    ${SALES_PASSWORD}
    Verify Element Validation Message    //input[@name="account"]    請填寫這個欄位。
    Verify Page URL    ${SALES_PORTAL_URL}/home?p=login
    [Teardown]    Reload Page

Login without any information
    [Tags]    CID:6660
    Login With Information    ${EMPTY}    ${EMPTY}
    Verify Element Validation Message    //input[@name="account"]    請填寫這個欄位。
    Verify Page URL    ${SALES_PORTAL_URL}/home?p=login
    [Teardown]    Reload Page

Login without password information
    [Tags]    CID:6659
    Login With Information    ${SALES_ACCOUNT}    ${EMPTY}
    Verify Element Validation Message    //input[@name="password"]    請填寫這個欄位。
    Verify Page URL    ${SALES_PORTAL_URL}/home?p=login

*** Keywords ***
Login With Information
    [Documentation]    keywords to decide login information, sleep 1s for avoiding recaptcha issue
    [Arguments]    ${account}   ${password}
    Sleep    1s
    Input Text In Element By Name    account    ${account}
    Input Text In Element By Name    password    ${password}
    Click Login Button

Test Teardown For Login With Wrong Information
    Click Button To Close Popup Window By Message    Error, L0001 Login fail. (Validation Error)
    Reload Page

Test Teardown For Privacy Policy
    Close Window
    Switch Window Tab    0